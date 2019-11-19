import cv2

# global variables
# bg = None


# def run_avg(image, aWeight):

    # Initialize the background


    # compute weighted average, accumulate it and update the background



# Segment region of hand in the image

# def segment(image, threshold=25):


    # Find the absolute difference between background and current image

    # Threshold the diff image so that we get the foreground


    # get the contours in the thresholded image

    # return None, if no contours detected

    # Detect center of the palm


# def detect_palm_center(segmented):
    # Find the convex hull of the segmented hand region

    # Find the center of the palm
    # c_y = int((extreme_top[0] + extreme_bottom[0]) / 2) # It used to be like that
