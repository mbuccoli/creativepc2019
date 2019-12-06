import cv2
import imutils
import numpy as np
import argparse
from pythonosc import udp_client

from joblib import dump,load
from hand_detection_utils import *
from SVR import *


# Background subtraction and stuff
# https://gogul.dev/software/hand-gesture-recognition-p1
# https://gogul.dev/software/hand-gesture-recognition-p2

# global variables
#bg = None

# Find running average over background

# -----------------
# MAIN FUNCTION
# -----------------


if __name__ == "__main__":
	# Usage info
	print('USAGE:')
	print('	-Before training generate the images for the the three classes:')
	print('		-Press "1" to save "class" 1 images')
	print('		-Press "2" to save "class" 2 images')
	print('		-Press "3" to save "class" 3 images')
	print('	-Press "s" to start SVR training (if a model has already been saved, it will be loaded)')
	print('	-Press  "q" to stop image capture')


	# initialize weight for running average
	aWeight = 0.5

	num_frames_train = 0

	# get the reference to the webcam
	camera = cv2.VideoCapture(0)

	TRAIN = False
	SVR = False

	# region of interest (ROI) coordinates
	top, right, bottom, left = 10, 350, 225, 590

	height_roi = bottom - top
	width_roi = left - right
	# initialize num of frames
	num_frames = 0

	# keep looping, until interrupted
	while True:
		# get the current frame
		(grabbed, frame) = camera.read()

		# resize the frame
		frame = imutils.resize(frame, width=700)

		# flip the frame so that it is not the mirror view
		frame = cv2.flip(frame, 1)

		# clone the frame
		clone = frame.copy()

		# get the height and width of the frame
		(height, width) = frame.shape[:2]

		# get the ROI
		roi = frame[top:bottom, right:left]

		# convert the roi to grayscale and blur it
		gray = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
		gray = cv2.GaussianBlur(gray, (7, 7), 0)

		# to get the background, keep looking till a threshold is reached
		# so that our running average model gets calibrated
		if num_frames < 30:
			run_avg(gray, aWeight)
		else:
			# segment the hand region
			hand = segment(gray)

			# check whether hand region is segmented
			if hand is not None:
				# if yes, unpack the thresholded image and
				# segmented region
				(thresholded, segmented) = hand

				# draw the segmented region and display the frame
				cv2.drawContours(clone, [segmented + (right, top)], -1, (0, 0, 255))

				if SVR:
					# Center of the hand
					c_x, c_y = detect_palm_center(segmented)
					radius = 5
					cv2.circle(thresholded, (c_x, c_y), radius, 0, 1)

					# Center of the hand

					# Map x and y axes
					x_axis = (c_x / width_roi) * 1270
					y_axis = (1-model.predict(np.array(thresholded).reshape(1, -1)))*720
					y_axis = (1 - (c_y/height_roi)) * 720
					client.send_message("/coords", [x_axis, float(y_axis)])

				# Draw thresholded hand
				cv2.imshow("Thesholded", thresholded)

		# draw the segmented hand
		cv2.rectangle(clone, (left, top), (right, bottom), (0, 255, 0), 2)

		# increment the number of frames
		num_frames += 1

		if TRAIN:
			if num_frames_train < tot_frames:
				# Change rectangle color to show that we are saving training images
				cv2.rectangle(clone, (left, top), (right, bottom), (255, 0, 0), 2)
				text = 'Generating ' + str(class_name) + ' images'
				cv2.putText(clone, text, (60, 45), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 2)

				# Save training images corresponding to the class
				cv2.imwrite('images/class_'+class_name+'/img_'+str(num_frames_train)+'.png', thresholded)
				num_frames_train += 1

			else:
				print('Class '+class_name+' images generated')
				TRAIN = False

			cv2.putText(clone, text, (70, 45), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)

		# display the frame with segmented hand
		cv2.imshow("Video Feed", clone)

		# observe the keypress by the user
		keypress = cv2.waitKey(1) & 0xFF

		# if the user pressed "q", then stop looping
		if keypress == ord("q"):
			break

		# Generate class 1 images
		if keypress == ord("1"):
			print('Generating the images for class A:')
			TRAIN = True
			num_frames_train = 0
			tot_frames = 250
			class_name = '1'

		# Generate class 2 images
		if keypress == ord("2"):
			print('Generating the images for class B:')
			TRAIN = True
			num_frames_train = 0
			tot_frames = 250
			class_name = '2'

		# Generate class 3 images
		if keypress == ord("3"):
			print('Generating the images for class B:')
			TRAIN = True
			num_frames_train = 0
			tot_frames = 250
			class_name = '3'

		# Start SVR regression or load model
		if keypress == ord('s'):
			SVR = True

			if not os.path.isfile('modelSVR.joblib'):
				model = train_svr()
			else:
				model = load('modelSVR.joblib')

			# Start OSC Client
			parser = argparse.ArgumentParser()
			parser.add_argument("--ip", default='127.0.0.1', help="The ip of the OSC server")
			parser.add_argument("--port", type=int, default=12000, help="The port the OSC server is listening on")
			args = parser.parse_args()
			client = udp_client.SimpleUDPClient(args.ip, args.port)


# free up memory
camera.release()
cv2.destroyAllWindows()


