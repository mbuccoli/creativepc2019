import cv2
import imutils
import numpy as np
import argparse
from pythonosc import udp_client

from joblib import dump,load
# from hand_detection_utils import *
# from SVM import *


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
	print('	-Before training generate the images for the the two classes press "a" for class 1 and "b" for class 2:')
	print('		-Press "a" to save class A images')
	print('		-Press "b" to save class B images')
	print('	-Press "s" to start SVM training (if a model has already been saved, it will be loaded)')
	print('	-Press "S" to start sound generation (must be pressed after training)')
	print('	-Press "T" to stop sound and "q" to stop image capture')

	# initialize weight for running average

	# get the reference to the webcam

	# Initialize variables


	# region of interest (ROI) coordinates

	# Dimensions of the image considered for hand detection


	# initialize num of frames

	# keep looping, until interrupted
	while True:
		# get the current frame

		# resize the frame

		# flip the frame so that it is not the mirror view

		# clone the frame

		# get the height and width of the frame

		# get the ROI

		# convert the roi to grayscale and blur it

		# to get the background, keep looking till a threshold is reached
		# so that our running average model gets calibrated

			# segment the hand region

			# check whether hand region is segmented
				# if yes, unpack the thresholded image and
				# segmented region

				# draw the segmented region and display the frame

				# Center of the hand

				# Center of the hand

		# draw the segmented hand

		# increment the number of frames

		# We want to generate and save the images corresponding to the two classes, in order to then save the model
		# if TRAIN:

		# Start SVM classification
		# if SVM:

			# Here we send the OSC message corresponding
			# if START_SOUND:

		# display the frame with segmented hand

		# observe the keypress by the user

		# if the user pressed "q", then stop looping
		# if keypress == ord("q"):

		# Generate class A images
		# if keypress == ord("a"):

		# Generate class B images
		# if keypress == ord("b"):

		# Train and/or start SVM classification
		# if keypress == ord('s'):

		# Start OSC communication and sound
		# if keypress == ord('S'):

		# Stop OSC communication and sound
		# if keypress == ord('T'):


# free up memory
camera.release()
cv2.destroyAllWindows()


