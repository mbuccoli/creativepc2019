# https://jakevdp.github.io/PythonDataScienceHandbook/05.07-support-vector-machines.html#Example:-Face-Recognition

import cv2
import os
import numpy as np
from sklearn.svm import SVR
from sklearn.decomposition import PCA
from sklearn.pipeline import make_pipeline
from sklearn.metrics import classification_report
from sklearn.model_selection import train_test_split
from sklearn.model_selection import GridSearchCV
from joblib import dump


def load_data(class_1_path, class_2_path,class_3_path):
    labels = []
    generate_arrays = True  # Create arrays where we store the dataset
    for img_name in os.listdir(class_1_path):
        if not img_name.startswith('.'):
            # Read the image
            img = cv2.imread(class_1_path + img_name, 0)
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

    for img_name in os.listdir(class_2_path):
        if not img_name.startswith('.'):
            # Read the image
            img = cv2.imread(class_2_path + img_name, 0)
            img = np.reshape(img, (1, img.shape[0], img.shape[1]))
            img_vector = np.reshape(img.ravel(), (1, -1))
            images = np.concatenate((images, img), axis=0)
            images_vector = np.concatenate((images_vector, img_vector), axis=0)

            labels.append(1)

    for img_name in os.listdir(class_3_path):
        if not img_name.startswith('.'):
            # Read the image
            img = cv2.imread(class_3_path + img_name, 0)
            img = np.reshape(img, (1, img.shape[0], img.shape[1]))
            img_vector = np.reshape(img.ravel(), (1, -1))
            images = np.concatenate((images, img), axis=0)
            images_vector = np.concatenate((images_vector, img_vector), axis=0)

            labels.append(0)

    return images, images_vector, labels


def train_svr():
	# Load data
	# class_names =
	
	# images, images_vector, labels =

	# pca =
	# model =

	# xtrain, xtest, ytrain, ytest =

	# Grid of parameters
	# param_grid =
	# grid =

	#print('Fit the SVR model')

	#

    # Generate the model
	# model

	# Save the model



	# return model


