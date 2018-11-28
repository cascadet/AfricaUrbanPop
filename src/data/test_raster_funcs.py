from src import raster_funcs
import numpy as np

def test_remove_isolated():
    mask1 = np.array([[1,0,0],[0,0,1],[0,0,0]])
    mask2 = np.array([[0,0,1],[0,0,0],[0,0,1]])
    removed = raster_funcs.remove_isolated_pixels(mask1, mask2)
    np.testing.assert_equal(removed, np.array([[0,0,1],[0,0,1],[0,0,1]]))