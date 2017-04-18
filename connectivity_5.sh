#!/bin/sh

# This script generate 3D point cloud graphics visualization of voxel data using 4 tiles data
# We use GRASS, GNUPLOT, AWK, within the bash shell

grass -text $INFOL/grassdb/ourLOCATION/yourMAPSET
INFOL=/path/to/voxel/layers_tif
OUTFOL=/path/to/output/folderPointCloud
OUT_VRT=/path/to/output/VRT_files
THRESHOLD=0.01
CITY=LT
for HEIGHT in $(seq 0 40) ; do
ls $INFOL/vox390.LT.21.21.$HEIGHT.tif > /tmp/tmp_list.txt
ls $INFOL/vox390.LT.21.20.$HEIGHT.tif >> /tmp/tmp_list.txt
ls $INFOL/vox390.LT.20.20.$HEIGHT.tif >> /tmp/tmp_list.txt
ls $INFOL/vox390.LT.20.21.$HEIGHT.tif >> /tmp/tmp_list.txt

gdalbuildvrt -input_file_list /tmp/tmp_list.txt $OUT_VRT/H_$HEIGHT.vrt
done
r.external -o input=$OUT_VRT/H_0.vrt output=LemRd.0
g.region raster=LemRd.0@FourTiles

# Mask vegetation 
r.external -o input=$INFOL/bess/maps/roughClass.$CITY.tif    output=$CITY.classmap@FourTiles    --overwrite  # 2m res layer
r.mapcalc "$CITY.class = $CITY.classmap "  --overwrite
g.remove -f type=raster name=$CITY.classmap@FourTiles
rm $OUTFOL/veg.xyz.txt
for HEIGHT in $(seq 0 40) ; do
r.external -o input=$OUT_VRT/H_$HEIGHT.vrt    output=lemRd.$HEIGHT     --overwrite  # 2m res layer
r.mapcalc  "lemRd.BIN.$HEIGHT  = if(isnull(lemRd.$HEIGHT),0, if(lemRd.$HEIGHT<$THRESHOLD,0,1))" --overwrite  # remove noise
r.mapcalc  "veg.$HEIGHT    = if($CITY.class<21, lemRd.BIN.$HEIGHT, $CITY.class)" --overwrite
r.mapcalc  "build.$HEIGHT    = if($CITY.class==40, lemRd.BIN.$HEIGHT, 0)" --overwrite
r.mapcalc  "road.$HEIGHT    = if($CITY.class==30, lemRd.BIN.$HEIGHT, 0)" --overwrite
r.out.xyz input=veg.$HEIGHT output=$OUTFOL/veg.$HEIGHT.csv separator="," --overwrite
r.out.xyz input=build.$HEIGHT output=$OUTFOL/build.$HEIGHT.csv separator="," --overwrite
r.out.xyz input=road.$HEIGHT output=$OUTFOL/road.$HEIGHT.csv separator="," --overwrite
awk -v HEIGHT=$HEIGHT -F, '{if($3==1)print $1" "$2" "HEIGHT" "$3}'  $OUTFOL/veg.$HEIGHT.csv >> $OUTFOL/veg.xyz.txt 
done

awk '{if($3>8)  print $0 }' $OUTFOL/veg.xyz.txt > $OUTFOL/trees.txt           # green 
awk '{if($3>0 && $3<9)  print $0 }' $OUTFOL/veg.xyz.txt > $OUTFOL/shrubs.txt  # blue
awk '{if($3==0 && $3<9)  print $0 }' $OUTFOL/veg.xyz.txt > $OUTFOL/shrubs.txt # yellow

gnuplot
set term png
set output "printme.png"
unset ytics
unset xtics
unset ztics
unset colorbox
set ztics ("0" 0, "" 5, "5" 10, "" 15, "10" 20, "" 25, "15" 30, "" 35, "20 m" 40) scale 2 font "Times-Roman, 20"
set palette defined ( 0 "orange", 1 "orange" , 1 "blue" , 9 "blue" , 9 "dark-green",  30 "dark-green" )
splot "/media/ste/backup/bess/voxels/LT_LeamingtonRd/pointCloud/veg.xyz.txt" using 1:2:3  with points palette pointsize 0.3 pointtype 7

set palette defined ( 9 "dark-green",  30 "dark-green" )
splot "/media/ste/backup/bess/voxels/LT_LeamingtonRd/pointCloud/trees.txt" using 1:2:3  with points palette pointsize 0.3 pointtype 7

set palette defined (  1 "blue" , 9 "blue"  )
splot "/media/ste/backup/bess/voxels/LT_LeamingtonRd/pointCloud/shrubs.txt" using 1:2:3  with points palette pointsize 0.3 pointtype 7

## Different type of visualization
rgb(r,g,b) = 65536 * int(r) + 256 * int(g) + int(b)
splot "/media/ste/backup/bess/voxels/LT_LeamingtonRd/pointCloud/veg.xyz.txt" using 1:2:3:(rgb($1,$2,$3)) with points lc rgb variable

# another visualization with different
splot "/media/ste/backup/bess/voxels/LT_LeamingtonRd/pointCloud/veg.xyz.txt" using 1:2:3:3 with dots palette
splot "/media/ste/backup/bess/voxels/LT_LeamingtonRd/pointCloud/veg.xyz.txt" using 1:2:3:4 with dots palette

