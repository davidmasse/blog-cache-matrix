# cached values
import numpy as np
from numpy.linalg import inv

def make_cache_matrix(matrix):
    inverse = None
    def set(new_matrix):
        nonlocal matrix
        matrix = new_matrix
        nonlocal inverse
        inverse = None
    def get():
        return matrix
    def set_inverse(new_inverse):
        nonlocal inverse
        inverse = new_inverse
    def get_inverse():
        return inverse
    return {'set' : set, 'get': get, 'set_inverse': set_inverse, 'get_inverse': get_inverse}

def cache_solve(function_dict):
    inverse = function_dict['get_inverse']()
    if inverse is not None:
        print("This inverse is retrieved from cache (previously calculated):")
        return(inverse)
    temp_matrix = function_dict['get']()
    inverse = inv(temp_matrix)
    function_dict['set_inverse'](inverse)
    print("This inverse is freshly calculated:")
    return inverse

test_matrix = np.append([[1, 9, 3], [5, 4, 6]], [[7, 5, 9]], axis=0)
test2 = np.append([[2, 9, 3], [5, 4, 6]], [[7, 5, 9]], axis=0)
