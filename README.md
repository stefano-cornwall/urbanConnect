# urbanConnect
3D connectivity in urban areas

See : Casalegno S., Anderson K., Cox D.T.C., Hancock S. & Gaston K.J. Ecological connectivity in the three-dimensional urban green volume using waveform airborne lidar. Submitted to Scientific Reports (Dic. 2011)

Prior to the below scripting routines it is required to process raw waveform LiDAR data using "voxelate.c" program available at https://bitbucket.org/StevenHancock/voxelate. The resulting layers generated fom "voxelate.c" are a series of GeoTIFF files reprsenting voxel (volumetric pixels) of 1.5m x 1.5m (X-Y) x 0.5m (Z) dimesions.

1. connectivity_0.sh It is a linux bash GRASS script creating an NDVI mask, read voxels layers from "voxelate.c" and generate 2D layers of vertically straified vegetation divided in grass (0-50cm); shrubs (51cm-3.5m) ; trees (3.51m - 30m). 

2. connectivity_1.sh generate raster maps with increasing buffer width for the overall vegetation, shrub, tree and grass layers in tree towns (Bedford, Luton, Milton Keynes). Then it computes the density of gardens for each layer and towns (optional, not required in the supporting article).

3. connectivity_2.py Python script to run in QGIS terminal. Computes the Landscape division index or conectivity index "CI" (i.e. the probability 2 random points in the landscape are connected by adjacent patches) recursively for each buffer map previously created.

4. connectivity_3.sh BASH AWK script. Prepare data to be imported in R.

5. connectivity_4.R R script. Plot graphics : Landsace division vs buffer size (functional connectivity) and Towns vs Landscape proportion, Small Patch Index, Large Patch Index, Connectivity Index (structural connectivity).

Software minimum requirements:
GRASS 6.4; AWK; LecoS – Landscape Ecology Statistics plugin version 2.6 under Qgis software version 2.14; Python version 2.7.12; R software version 3.2.3.

N.B. The use of the OsGeo-live virtual machine https://live.osgeo.org/ has all software requirement pre-installed.
