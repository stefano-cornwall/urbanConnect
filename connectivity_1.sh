# Start grass
grassdb=/disk2/bess/grassdb
location=BESS27700
mapset=PERMANENT
inDIR=/disk2/bess/connectivity/locosProces/input_tif
grass -text  $grassdb/$location/$mapset
g.mapset -c mapset=lecosProcess

LAYER=all
for CITY in BD MK LT ; do echo $CITY
r.in.gdal -e input=$inDIR/$CITY.$LAYER.tif output=$CITY.$LAYER --overwrite
g.region rast=$CITY.$LAYER save=$CITY.gregion --overwrite
done

for CITY in BD MK LT ; do echo $CITY
g.region region=$CITY.gregion
for LAYER in all grass shrubs trees ; do 
g.remove rast=$CITY.$LAYER
r.in.gdal -e input=$inDIR/$CITY.$LAYER.tif output=$CITY.$LAYER --overwrite
r.mapcalc "mask.$CITY = if($CITY.$LAYER >= 0 , 1 ,null())"
r.mask -o input=mask.$CITY
r.mapcalc "$CITY.$LAYER.01 = if($CITY.$LAYER == 2 , 0 , 1)"

r.buffer -z input=$CITY.$LAYER.01 output=$CITY.$LAYER.BUF distances=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,250,260,270,280,290,300,320,340,480,500 --overwrite

for BUFFER in $(seq 2 $(r.info -r $CITY.$LAYER.BUF | grep max | awk -F\= '{print $2}')) ; do 
r.mapcalc "$CITY.$LAYER.BUF.$BUFFER = if($CITY.$LAYER.BUF <= $BUFFER , 1 , 0)"
r.out.gdal nodata=3 input=$CITY.$LAYER.BUF.$BUFFER output=/disk2/bess/connectivity/locosProces/bufferTif/$CITY.buff/$CITY.$LAYER.BUF.$BUFFER.tif
g.remove rast=$CITY.$LAYER.BUF.$BUFFER
done
done
done


# Compute garden density (or patch with sizes < 
rm Garden30m_density.csv
r.mask -r
for CITY in BD MK LT ; do echo $CITY 
g.region region=$CITY.gregion
for LAYER in all grass shrubs trees ; do 
r.reclass.area input=$CITY.$LAYER.01  output=garden.$CITY.$LAYER lesser=0.003 --overwrite

r.clump input=garden.$CITY.$LAYER output=clumpGarden.$CITY.$LAYER --overwrite
r.report -n map=clumpGarden.$CITY.$LAYER units=c  | awk -F\| '{print $2 , $3 }' > tmp
TGarden=$(tail -4 tmp | awk '{if(NR==1) print $1 }')
r.report -n units=c map=$CITY.$LAYER.01 | awk -F\| '{print $2 , $3 }' > tmp
TArea=$(tail -2 tmp | awk '{if(NR==1)print $2 }')
GDensity=$(awk -v TGarden=$TGarden  -v TArea=$TArea 'BEGIN {print TGarden/TArea}')
echo $CITY","$LAYER","$GDensity >> Garden30M_density.csv
done
done
