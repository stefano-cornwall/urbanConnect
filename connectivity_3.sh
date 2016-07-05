
## Run this script after lecos.buffer.py

for CITY in MK ; do 
  for LAYER in all grass shrubs trees ; do 
    for file in $(seq 2 90) ; do 
     tail -1  /disk2/bess/connectivity/locosProces/outCSV/$CITY.17.$LAYER.$file.csv | awk -F\; '{print$2}' >> /disk2/bess/connectivity/locosProces/functional/$CITY.17.$LAYER.values.txt 
    done
  done
done
