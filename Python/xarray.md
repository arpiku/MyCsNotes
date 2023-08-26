[[dask.array]]
# xarray
#ImpLink : https://tutorial.xarray.dev/overview/xarray-in-45-min.html
xarray is a superset library of numpy, it provides all the funcitionlalites of numpy but adds on to it the ability to name the dimensions, basically making handling array a bit more human readable, it also adds extra properties to an array such as attributes.

It mainly offers two data structures:
DataArray: A labeled N-dimensional array
DataSet: It's a data structure that is used to represent a multi-dimensional array which is dict-like container holding.

# DataArray
~~~python 
import xarray as xr
data = np.array(5,4)
xr.DataArray(data, dims=None,coords=None,attrs=None,name=None)

~~~

dtype, shape, size, ndim, nbytes

““““{{}}