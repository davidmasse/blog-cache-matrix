import numpy as np
from numpy.linalg import inv

class Mat_with_cache:

    def __init__(self, init_matrix, init_inverse = None):
        self._matrix = init_matrix
        self._inverse = init_inverse

    @property
    def matrix(self):
        return self._matrix

    @matrix.setter
    def matrix(self, new_matrix):
        self._matrix = new_matrix
        self._inverse = None

    @property
    def inverse(self):
        return self._inverse

    @inverse.setter
    def inverse(self, new_inverse):
        self._inverse = new_inverse

def cache_solve(mwc):
    inverted = mwc.inverse
    if inverted is not None:
        print("This inverse is retrieved from cache (previously calculated):")
        return(inverted)
    temp_matrix = mwc.matrix
    inverted = inv(temp_matrix)
    mwc.inverse = inverted
    print("This inverse is freshly calculated:")
    return inverted

test_matrix = np.append([[1, 9, 3], [5, 4, 6]], [[7, 5, 9]], axis=0)
test2 = np.append([[2, 9, 3], [5, 4, 6]], [[7, 5, 9]], axis=0)
