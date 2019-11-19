
import cv2
import os
import numpy as np
from sklearn.svm import SVC
from sklearn.decomposition import PCA
from sklearn.pipeline import make_pipeline
from sklearn.metrics import classification_report
from sklearn.model_selection import train_test_split
from joblib import dump
from sklearn.model_selection import GridSearchCV


def load_data(class_a_path, class_b_path):

	labels = []
	generate_arrays = True  # Create arrays where we store the dataset
	for img_name in os.listdir(class_a_path):
		if not img_name.startswith('.'):
			# Read the image
			img = cv2.imread(class_a_path + img_name, 0)
			img = np.reshape(img, (1, img.shape[0], img.shape[1]))
			img_vector = np.reshape(img.ravel(), (1, -1))

			# Create arrays where we store the dataset executed only at beginning
			if generate_arrays:
				images = img
				images_vector = img_vector
				generate_arrays = False
			else:
				images = np.concatenate((images, img), axis=0)
				images_vector = np.concatenate((images_vector, img_vector), axis=0)

			labels.append(0)

	for img_name in os.listdir(class_b_path):
		if not img_name.startswith('.'):
			# Read the image
			img = cv2.imread(class_b_path + img_name, 0)
			img = np.reshape(img, (1, img.shape[0], img.shape[1]))
			img_vector = np.reshape(img.ravel(), (1, -1))
			images = np.concatenate((images, img), axis=0)
			images_vector = np.concatenate((images_vector, img_vector), axis=0)

			labels.append(1)

	return images, images_vector, labels


def train_svm():
	# Load data
	# class_names = ...
	
	# images, images_vector, labels =

	# pca = ...
	# svc =  ...
	# model = ...

	# xtrain, xtest, ytrain, ytest = ...

	# param_grid = ...
	# grid = ...

	print('Fit the SVM model')

	# Fit the SVM model
	# ..

	# Generate best model
	# model =

	# Save the model
	# ...

	# return model


