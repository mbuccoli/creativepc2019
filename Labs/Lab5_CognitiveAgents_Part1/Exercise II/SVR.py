# https://jakevdp.github.io/PythonDataScienceHandbook/05.07-support-vector-machines.html#Example:-Face-Recognition

import cv2
import os
import numpy as np
from sklearn.svm import SVR
from sklearn.decomposition import PCA as RandomizedPCA
from sklearn.pipeline import make_pipeline
from sklearn.metrics import classification_report
from sklearn.model_selection import train_test_split
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
    class_names = ['1', '2', '3']

    images, images_vector, labels = load_data(class_1_path='images/class_1/',
                                              class_2_path='images/class_2/',
                                              class_3_path='images/class_3/')

    pca = RandomizedPCA(n_components=150, svd_solver='randomized', whiten=True, random_state=42)
    svr = SVR(kernel='rbf')
    model = make_pipeline(pca, svr)

    Xtrain, Xtest, ytrain, ytest = train_test_split(images_vector, labels,
                                                    random_state=42)

    from sklearn.model_selection import learning_curve, GridSearchCV
    param_grid = {'svr__C': [1, 5, 10, 50],
                  'svr__gamma': [0.0001, 0.0005, 0.001, 0.005]}
    grid = GridSearchCV(model, param_grid)

    grid.fit(Xtrain, ytrain)

    model = grid.best_estimator_

    # Save the model
    dump(model, 'modelSVR.joblib')


    return model


