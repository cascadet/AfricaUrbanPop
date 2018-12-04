import numpy as np
import scipy.ndimage as ndimage

def get_numbered_arr(highpop_mask, lowpop_mask):
    '''
    Only works if mask_600 represents a binary array
    where pixels are 1 if they have over 600 people.
    We take the exclusive or to get cell sthat have less than
    1000 people but greater than 600. we then use maximum to give
    us an array where each pixel has a nonbinary value.
    '''
    arr_justlow = np.logical_xor(highpop_mask, lowpop_mask)*600
    arr_justhigh = highpop_mask*1000
    return np.maximum(arr_justlow, arr_justhigh)
    
    
def remove_isolated_pixels(highpop_mask, lowpop_mask, struct=np.ones((3,3))):
    """
    Removes pixels in lowpopmask that are not connected to high pop pixels.
    Struct should be a binary 3x3 numpy array to define
    connectivity rule. Binary mask arrays should be the 
    shape. lowpop_mask is lower threshold highpop_mask is higher


    take labeled union array. do valid = valid get max value, if it is 1000 keep it if not don't keep
    use region props intensity image
    """

    def get_bad_indices(label_arr, indices):
        """
        Used with scipy.ndimage.label_comprehension to get
        list of list of bad linear indices of the original array
        of labels.
        """
        if np.max(label_arr) == 600:
            return list(indices)
    
    id_regions, num_ids = ndimage.label(lowpop_mask, structure=struct)
    id_sizes = np.array(ndimage.sum(lowpop_mask, id_regions, range(num_ids + 1)))
    pop_arr = get_numbered_arr(highpop_mask, lowpop_mask)
    del highpop_mask
    bad_linear_indices = ndimage.labeled_comprehension(pop_arr, func = get_bad_indices, labels=id_regions, index = np.arange(1, num_ids + 1), pass_positions=True, out_dtype=list, default=-1)
    del pop_arr
    del id_regions
    flat_mask = lowpop_mask.flatten()
    for i in bad_linear_indices:
        if i is not None:
            flat_mask[i] = 0
    return flat_mask.reshape(lowpop_mask.shape)

def old_remove_isolated_pixels(mask1000, mask600, struct=np.ones((3,3))):
    """
    Unions two binary numpy arrays of the same shape.
    Takes this unioned array and removes solitary pixels.
    Struct should be a binary 3x3 numpy array to define
    connectivity rule. Binary mask arrays should be the 
    shape.
    """
    union_arr = np.logical_or(mask1000, mask600)*1
    id_regions, num_ids = ndimage.label(union_arr, structure=struct)
    id_sizes = np.array(ndimage.sum(union_arr, id_regions, range(num_ids + 1)))
    area_mask = (id_sizes == 1)
    union_arr[area_mask[id_regions]] = 0
    return union_arr