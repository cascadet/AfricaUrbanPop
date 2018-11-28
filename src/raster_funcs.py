import rasterio
from skimage import measure
import numpy as np

mask1 = "./src/data/africa1k_2000_mask600.tif"
mask2 = "./src/data/africa1k_2000_mask1000.tif"


africa1k_600 = rasterio.open(mask1).read(1)

africa1k_1000 = rasterio.open(mask2).read(1)


def remove_isolated_pixels(mask1, mask2, noise_threshold=1, struct=2):
    """
    Unions two rbinary numpy arrays of the same shape.
    Takes this unioned array and removes solitary pixels.
    noise_threshold defines the grouping amount for pixels 
    to be considered solitary and removed.
    Can easily be adjusted to remove groups of pixels 
    of size 2, 3, etc. See links for details
    http://scikit-image.org/docs/dev/api/skimage.measure.html#skimage.measure.label
    https://stackoverflow.com/questions/46143800/removing-isolated-pixels-using-opencv
    """
    union_arr = np.logical_or(mask1, mask2)*1
    labeled = measure.label(union_arr,connectivity=struct)
    for label_id in np.unique(labeled):
        if (labeled == label_id).sum() == noise_threshold:
            labeled[labeled == label_id] = 0
    return labeled

remove_isolated_pixels(africa1k_600, africa1k_1000)


