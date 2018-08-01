## Patterned on the makeVector and cacheMean functions given in programming
## assignment 2: lexical scoping.  These functions allow one to cache a matrix
## and its inverse so that the inverse can be retrieved without recalculating
## if the matrix has not changed.

## makeCacheMatrix below takes a matrix (assumed to be square invertible) and
## returns a list of four basic named functions (setters and getters).

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  ## Set up a variable to be used for the inverse of the matrix
  ## will later test whether this value is null to decide whether
  ## needs to be calculated.
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  ## If this basic function is called, x is re-assigned to a newly provided
  ## matrix y.  The <<- form of assignment operator means that x will now have
  ## values of y even in the parent environment (makeCacheMatrix).  Since we
  ## have a new matrix, the inverse is not yet calculated, so inv is set back
  ## to null.  This is essentially repeating the opening of makeCacheMatrix
  ## but substituting in a new matrix.  set() is not called in cacheSolve, but
  ## it is useful separately if we want to manually update the matrix we're
  ## using without re-running makeCacheMatrix.  y is a dummy variable used
  ## only within set() as a temporary name for the new matrix to be assigned
  ## to x.
  get <- function() x
  ## x is defined at the parent level, so lexical scoping allows its
  ##retrieval within get()
  setinv <- function(inverse) inv <<- inverse
  ## Allows us to update the cached inverse matrix with what would be calculated
  ## by solve(x).  This is done in the parent environment (makeCacheMatrix) as
  ## well.
  getinv <- function() inv
  ## inv is defined at the parent level, so lexical scoping allows its
  ## retrieval within getinv()
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
  ## Returns a list of the basic functions above.  These are given eponymous
  ## names (for reference via the $ operator)
}

## cacheSolve below returns a matrix that is the inverse of x.  If the inverse has
## already been calculated, it returns the cached value and says it's cached.
## Otherwise it calculates the inverse matrix and returns it.

cacheSolve <- function(x, ...) {
  ## The x argument here is not the original plain matrix x but rather
  ## the output of makeCacheMatrix, which includes access to stored values
  ## for the matrices x and inv in the parent environment (makeCacheMatrix)
  inv <- x$getinv()
  ## The current value of inv - possibly NULL - is pulled from the expanded
  ## matrix passed to cacheSolve
  if(!is.null(inv)) {
    message("This inverse is retrieved from cache (previously calculated):")
    return(inv)
  }
  ## If inv is not NULL (i.e. it has been calculated already), this alerts
  ## the used that data retrieved had been cached and then gives the cached
  ## value, ending the cacheSolve function due to the use of return().
  data <- x$get()
  ## This and the below only runs if inv is NULL.  data is a dummy variable
  ## to hold the result of executing the "get" function in the x list
  ## of functions (i.e. the original x matrix in the parent environment).
  inv <- solve(data, ...)
  ## Calculates the inverse matrix
  x$setinv(inv)
  ## Runs the basic function to assign the result of the calculation to inv
  ## in the parent environment.
  message("This inverse is freshly calculated:")
  inv
  ## Outputs the caluclated inverse matrix - without saying it is retrieved
  ## from a cache.
}

test_matrix <- matrix(c(3,2,4,1,5,6,2,2,4), nrow=3, ncol = 3)
