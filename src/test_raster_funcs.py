from src import raster_funcs
import numpy as np

def test_remove_isolated_8_connectivity():
    mask1000 = np.array([[1,0,0,0],[0,0,1,0],[0,0,0,0],[0,0,0,1]])
    mask600 = np.array([[1,0,1,0],[0,0,1,0],[0,0,1,0],[1,0,0,1]])
    removed = raster_funcs.remove_isolated_pixels(mask1000, mask600)
    good_result = np.array([[1,0,1,0],[0,0,1,0],[0,0,1,0],[0,0,0,1]])
    print('1000:')
    print(mask1000)
    print('600:')
    print(mask600)
    print('removed:')
    print(removed)
    print('good:')
    print(good_result)
    np.testing.assert_equal(removed, good_result)