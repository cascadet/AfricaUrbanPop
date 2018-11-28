import numpy as np
import scipy.ndimage as ndimage

def remove_isolated_pixels(mask1, mask2, struct=np.ones((3,3))):
    """
    Unions two binary numpy arrays of the same shape.
    Takes this unioned array and removes solitary pixels.
    Struct should be a binary 3x3 numpy array to define
    connectivity rule. Binary mask arrays should be the 
    shape.
    """
    union_arr = np.logical_or(mask1, mask2)*1
    id_regions, num_ids = ndimage.label(union_arr, structure=struct)
    id_sizes = np.array(ndimage.sum(union_arr, id_regions, range(num_ids + 1)))
    area_mask = (id_sizes == 1)
    union_arr[area_mask[id_regions]] = 0
    return union_arr

