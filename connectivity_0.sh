#!/bin/sh
#$ -S /bin/bash

# run it using:

# for CITY in LT BD MK ; do FILTER=disII ; THRESHOLD=0.01 ; echo  qsub -e /home/ISAD/sc517/MYbess/stderr -o /home/ISAD/sc517/MYbess/stdout MYbess/bess_script/discVsFullwave.sh $CITY $FILTER $THRESHOLD ; done

# or test it in one node using qlogin and paste single commands
# grass -text /home/ISAD/sc517/MYbess/grassdb/epsg27700/PERMANENT/

###########################  add modules
. /etc/profile.d/modules.sh
module add shared sge gcc/4.8.1 acml/gcc/64/5.3.1 proj gdal GRASS

export CITY=$1
export FILTER=$2
export THRESHOLD=$3

echo ok >     /home/ISAD/sc517/MYbess/$CITY"info.txt"
echo $CITY >> /home/ISAD/sc517/MYbess/$CITY"info.txt"
echo "LOCATION_NAME: epsg27700"           >  $HOME/.grassrc7_$$ # or $HOME/.grassrc7_$$
echo "MAPSET: PERMANENT"                  >> $HOME/.grassrc7_$$
echo "DIGITIZER: none"                    >> $HOME/.grassrc7_$$
echo "GRASS_GUI: text"                    >> $HOME/.grassrc7_$$
echo "GISDBASE: /home/ISAD/sc517/MYbess/grassdb"                 >> $HOME/.grassrc7_$$
export GISBASE=/cm/shared/apps/GRASS/7.0/grass-7.0.svn  ## while using grass 7
export PATH=$PATH:$GISBASE/bin:$GISBASE/scripts:/shared-md/apps/gdal/gcc/1.10.1
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GISBASE/lib"
export PYTHONPATH=/cm/shared/apps/GRASS/7.0/grass-7.0.svn/etc/python
export GISRC=~/.grassrc7_$$
export GIS_LOCK=$$

INMp=/local/sc517                   # tif fles are copied locally and vrt are read locally
OUTd=/home/ISAD/sc517/MYbess/tables/$FILTER.$CITY
newmapsest=/home/ISAD/sc517/MYbess/grassdb/epsg27700/$FILTER.$CITY

if [ -d "$newmapset" ] ; then rm -r $newmapset ; fi
if [ -d "$OUTd" ] ; then rm -r $OUTd ; mkdir $OUTd ; cd $OUTd ; else mkdir $OUTd ; cd $OUTd ; fi

if [ "$CITY" == "BD" ] ; then 
g.mapset -c mapset=$FILTER.$CITY
g.region n=254158.25 s=242518.25 w=499007.25 e=511323.75 res=1.5

elif [ "$CITY" == "MK" ] ; then 
g.mapset -c mapset=$FILTER.$CITY
g.region n=246187.25 s=230276.75 w=479217.75 e=494367.75 res=1.5

else
g.mapset -c mapset=$FILTER.$CITY
g.region n=229638.25 s=217158.25 w=499329.25 e=514092.25 res=1.5
fi

HEIGHT=0
rm $INMp/vox390.$CITY.*.*.$HEIGHT.tif
cp /home/groups/bess/voxels/voxGround/vox390.$CITY.*.*.$HEIGHT.tif  $INMp/.
ls $INMp/vox390.$CITY.*.*.$HEIGHT.tif > /home/ISAD/sc517/MYbess/lists/$CITY$HEIGHT.txt
rm $INMp/a$CITY$HEIGHT.vrt
gdalbuildvrt -input_file_list /home/ISAD/sc517/MYbess/lists/$CITY$HEIGHT.txt $INMp/a$CITY$HEIGHT.vrt
file=$INMp/a$CITY$HEIGHT.vrt
r.in.gdal -o input=$file output=template.$HEIGHT$CITY    --overwrite




## CREATE A MASK of VEGETATED area using NDVI
r.external -o input=/home/groups/bess/maps/roughClass.$CITY.tif    output=$CITY.classmap     --overwrite  # 2m res layer
r.mapcalc "$CITY.ndvi = if($CITY.classmap<21,1,0)"  --overwrite
r.mapcalc "ward.veg.mask.$CITY = if($CITY.ndvi==1,1,null())"   ### MASK of vegetated areas in WARD 

#######################################################################
# PROCESS VOXELS LAYERS
# merge tiles into mosaics for each of the 60 height layers : VRT$HEIGHT
# mask non vegetated areas
# change zero treshold and replace null with zero into the original voxels values : VOX.DEN.$HEIGHT 
# change zero treshold; replace null values with zero; convert the original voxels values into binary 0 - 1 maps  : VOX.BIN.$HEIGHT 
# compute a layer with the maximum height at the specific threshold of 0-1 binary voxels:  max.height.$CITY ( N.B. this is different from the accumulated positive voxels)

r.mask raster=ward.veg.mask.$CITY --overwrite ## process only vegetated areas
r.mapcalc  "max.height.$CITY = 0" --overwrite
for HEIGHT in $(seq 0 60) ; do #echo $HEIGHT ; done
rm $INMp/vox390.$CITY.*.*.$HEIGHT.tif
cp /home/groups/bess/voxels/voxGround/vox390.$CITY.*.*.$HEIGHT.tif  $INMp/.
ls $INMp/vox390.$CITY.*.*.$HEIGHT.tif > /home/ISAD/sc517/MYbess/lists/$CITY$HEIGHT.txt
rm $INMp/a$CITY$HEIGHT.vrt
gdalbuildvrt -input_file_list /home/ISAD/sc517/MYbess/lists/$CITY$HEIGHT.txt $INMp/a$CITY$HEIGHT.vrt
file=$INMp/a$CITY$HEIGHT.vrt
r.in.gdal -o input=$file output=VRT$HEIGHT    --overwrite
r.mapcalc  "VOX.DEN.$HEIGHT = if(isnull(VRT$HEIGHT),0, if(VRT$HEIGHT<$THRESHOLD,0,VRT$HEIGHT))" --overwrite
r.mapcalc  "VOX.BIN.$HEIGHT = if(isnull(VRT$HEIGHT),0, if(VRT$HEIGHT<$THRESHOLD,0,1))" --overwrite
r.mapcalc  "tmp.max.$HEIGHT = if(VOX.BIN.$HEIGHT==1,$HEIGHT+1,max.height.$CITY)" --overwrite
r.mapcalc  "max.height.$CITY = tmp.max.$HEIGHT" --overwrite
while read -r file2rm ; do rm "$file2rm" ; done < /home/ISAD/sc517/MYbess/lists/$CITY$HEIGHT.txt
done

##############################################################
# DENSITY OF VEGETATION PER STRATA 
# Accumulated voxel density for different stara of vegetation : 0-Grass; 1-Shrubs; 2-Short trees; 3-Tall trees; 4-All trees; 5-All woody vegetation; 6-All vegetation
#
# 0: grass
r.mapcalc "$CITY.Accu.VOX.DEN.0 =  VOX.DEN.0" --overwrite
# 1: shrub
r.mapcalc "$CITY.Accu.VOX.DEN.1 =  VOX.DEN.1 + VOX.DEN.2 + VOX.DEN.3 + VOX.DEN.4 + VOX.DEN.5 + VOX.DEN.6 + VOX.DEN.7 " --overwrite 
# 2: short trees
r.mapcalc "$CITY.Accu.VOX.DEN.2 = VOX.DEN.8 + VOX.DEN.9 + VOX.DEN.10 + VOX.DEN.11 + VOX.DEN.12 + VOX.DEN.13 + VOX.DEN.14 + VOX.DEN.15 + VOX.DEN.16 + VOX.DEN.17 + VOX.DEN.18 + VOX.DEN.19 + VOX.DEN.20 + VOX.DEN.21 + VOX.DEN.22 + VOX.DEN.23 + VOX.DEN.24 + VOX.DEN.25 + VOX.DEN.26 + VOX.DEN.27 + VOX.DEN.28 + VOX.DEN.29" --overwrite 
# 3: tall trees
r.mapcalc "$CITY.Accu.VOX.DEN.3 = VOX.DEN.30 + VOX.DEN.31 + VOX.DEN.32 + VOX.DEN.33 + VOX.DEN.34 + VOX.DEN.35 + VOX.DEN.36 + VOX.DEN.37 + VOX.DEN.38 + VOX.DEN.39 + VOX.DEN.40 + VOX.DEN.41 + VOX.DEN.42 + VOX.DEN.43 + VOX.DEN.44 + VOX.DEN.45 + VOX.DEN.46 + VOX.DEN.47+ VOX.DEN.48 + VOX.DEN.49 + VOX.DEN.50 + VOX.DEN.51 + VOX.DEN.52 + VOX.DEN.53 + VOX.DEN.54 + VOX.DEN.55 + VOX.DEN.56 + VOX.DEN.57 + VOX.DEN.58 + VOX.DEN.59 + VOX.DEN.60 " --overwrite 
# 4: trees
r.mapcalc "$CITY.Accu.VOX.DEN.4 = $CITY.Accu.VOX.DEN.3 + $CITY.Accu.VOX.DEN.2" --overwrite 
# 5: woody veg
r.mapcalc "$CITY.Accu.VOX.DEN.5 = $CITY.Accu.VOX.DEN.3 + $CITY.Accu.VOX.DEN.2 + $CITY.Accu.VOX.DEN.1" --overwrite 
# 6: all vegetation
r.mapcalc "$CITY.Accu.VOX.DEN.6 = $CITY.Accu.VOX.DEN.0 + $CITY.Accu.VOX.DEN.5" --overwrite 


##############################################################
# PRESENCE / ABSENCE OF VEGETATION PER STRATA -- MINDCRAFT world ---
## Accumulated voxel (binary) for different strata to calculate cubic meter per ha. 
# 0-Grass; 1-Shrubs; 2-Short trees; 3-Tall trees; 4-All trees; 5-All woody vegetation; 6-All vegetation
# grass
r.mapcalc "$CITY.Accu.VOX.BIN.0 =  VOX.BIN.0" --overwrite
# shrub
r.mapcalc "$CITY.Accu.VOX.BIN.1 =  VOX.BIN.1 + VOX.BIN.2 + VOX.BIN.3 + VOX.BIN.4 + VOX.BIN.5 + VOX.BIN.6 + VOX.BIN.7 " --overwrite
# short trees
r.mapcalc "$CITY.Accu.VOX.BIN.2 = VOX.BIN.8 + VOX.BIN.9 + VOX.BIN.10 + VOX.BIN.11 + VOX.BIN.12 + VOX.BIN.13 + VOX.BIN.14 + VOX.BIN.15 + VOX.BIN.16 + VOX.BIN.17 + VOX.BIN.18 + VOX.BIN.19 + VOX.BIN.20 + VOX.BIN.21 + VOX.BIN.22 + VOX.BIN.23 + VOX.BIN.24 + VOX.BIN.25 + VOX.BIN.26 + VOX.BIN.27 + VOX.BIN.28 + VOX.BIN.29" --overwrite 

r.mapcalc "$CITY.Accu.VOX.BIN.3 = VOX.BIN.30 + VOX.BIN.31 + VOX.BIN.32 + VOX.BIN.33 + VOX.BIN.34 + VOX.BIN.35 + VOX.BIN.36 + VOX.BIN.37 + VOX.BIN.38 + VOX.BIN.39 + VOX.BIN.40 + VOX.BIN.41 + VOX.BIN.42 + VOX.BIN.43 + VOX.BIN.44 + VOX.BIN.45 + VOX.BIN.46 + VOX.BIN.47+ VOX.BIN.48 + VOX.BIN.49 + VOX.BIN.50 + VOX.BIN.51 + VOX.BIN.52 + VOX.BIN.53 + VOX.BIN.54 + VOX.BIN.55 + VOX.BIN.56 + VOX.BIN.57 + VOX.BIN.58 + VOX.BIN.59 + VOX.BIN.60 " --overwrite 
# trees
r.mapcalc "$CITY.Accu.VOX.BIN.4 = $CITY.Accu.VOX.BIN.3 + $CITY.Accu.VOX.BIN.2" --overwrite 
# woody veg
r.mapcalc "$CITY.Accu.VOX.BIN.5 = $CITY.Accu.VOX.BIN.3 + $CITY.Accu.VOX.BIN.2 + $CITY.Accu.VOX.BIN.1" --overwrite 
# all vegetation
r.mapcalc "$CITY.Accu.VOX.BIN.6 = $CITY.Accu.VOX.BIN.0 + $CITY.Accu.VOX.BIN.5" --overwrite 

