import cv2

# global variables
bg = None


def run_avg(image, aWeight):
    global bg
    # Initialize the background

    if bg is None:

        bg = image.copy().astype("float")

    # compute weighted average, accumulate it and update the background

    cv2.accumulateWeighted(image, bg, aWeight)


# Segment region of hand in the image

def segment(image, threshold=25):
    global bg

    # Find the absolute difference between background and current image
    diff = cv2.absdiff(bg.astype("uint8"), image)

    # Threshold the diff image so that we get the foreground

    thresholded = cv2.threshold(diff, threshold, 255, cv2.THRESH_BINARY)[1]

    # get the contours in the thresholded image
    (_, cnts, _) = cv2.findContours(thresholded.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # return None, if no contours detected
    if len(cnts) == 0:
        return
    else:
        segmented = max(cnts, key=cv2.contourArea)
        return thresholded, segmented

    # Detect center of the palm


def detect_palm_center(segmented):
    # Find the convex hull of the segmented hand region
    chull = cv2.convexHull(segmented)

    # Find the most extreme points in the convex hull
    extreme_top = tuple(chull[chull[:, :, 1].argmin()][0])
    extreme_bottom = tuple(chull[chull[:, :, 1].argmax()][0])
    extreme_left = tuple(chull[chull[:, :, 0].argmin()][0])
    extreme_right = tuple(chull[chull[:, :, 0].argmax()][0])

    # Find the center of the palm
    c_x = int((extreme_left[0] + extreme_right[0]) / 2)
    c_y = int((extreme_top[1] + extreme_bottom[1]) / 2)
    return c_x, c_y
