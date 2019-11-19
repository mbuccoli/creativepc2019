import cv2
import imutils
import numpy as np
import argparse
from pythonosc import udp_client

from joblib import dump,load
from hand_detection_utils import *
#from SVR import *


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
	print('		-Press "1" to save class 1 images')
	print('		-Press "2" to save class 2 images')
	print('		-Press "3" to save class 3 images')
	print('	-Press "s" to start SVR training (if a model has already been saved, it will be loaded)')
	print('	-Press  "q" to stop image capture')

	# initialize weight for running average

	# get the reference to the webcam

	# region of interest (ROI) coordinates

	# initialize num of frames

	# keep looping, until interrupted
	# while True:
		# get the current frame

		# resize the frame

		# flip the frame so that it is not the mirror view

		# clone the frame

		# get the height and width of the frame

		# get the ROI

		# convert the roi to grayscale and blur it

		# to get the background, keep looking till a threshold is reached
		# so that our running average model gets calibrated

			# check whether hand region is segmented
			# if hand is not None:


				# if SVR:

				# Draw thresholded hand

		# draw the segmented hand

		# increment the number of frames

		# if TRAIN:

		# display the frame with segmented hand

		# observe the keypress by the user

		# if the user pressed "q", then stop looping
		# if keypress == ord("q"):

		# Generate class 1 images
		# if keypress == ord("1"):


		# Generate class 2 images
		# if keypress == ord("2"):

		# Generate class 3 images
		# if keypress == ord("3"):


		# Start SVR regression or load model
		# if keypress == ord('s'):



# free up memory
camera.release()
cv2.destroyAllWindows()


