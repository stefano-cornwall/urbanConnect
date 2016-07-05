import os
import os.path
import processing

INPATH = '/disk2/bess/connectivity/locosProces/bufferTif/'
INFOL = '.buff/'
INFILE = '.BUF.'
CITYlist = ['MK', 'BD', 'LT']
LAYERlist = ['all', 'grass', 'shrubs', 'trees']

for CITY in CITYlist:
    for LAYER in LAYERlist:
    print LAYER
    for BUF in range (0, 90):
        #print INPATH + CITY + INFOL + CITY + '.' + LAYER + INFILE + str(BUF) + '.tif'
        infile = INPATH + CITY + INFOL + CITY + '.' + LAYER + INFILE + str(BUF) + '.tif'
        #print '/disk2/bess/connectivity/locosProces/outCSV/' + CITY + '.17.' + LAYER + '.' + str(BUF) + '.csv'
        #outcsv1 = '/disk2/bess/connectivity/locosProces/outCSV/' + CITY + '.01.' + LAYER + '.' + str(BUF) + '.csv'
        #outcsv3 = '/disk2/bess/connectivity/locosProces/outCSV/' + CITY + '.03.' + LAYER + '.' + str(BUF) + '.csv'
        outcsv17 = '/disk2/bess/connectivity/locosProces/outCSV/' + CITY + '.17.' + LAYER + '.' + str(BUF) + '.csv'
        print infile
        print outcsv17
        if os.path.exists(infile):
           print "File exists and is readable"
           #processing.runalg("lecos:patchstatistics",infile,1,1,outcsv1)
           #processing.runalg("lecos:patchstatistics",infile,1,3,outcsv3)
           processing.runalg("lecos:patchstatistics",infile,1,17,outcsv17)
        else:
           print "Either file is missing or is not readable"


#We compute the Landscape division
#processing.runalg("lecos:patchstatistics","/disk2/bess/connectivity/locosProces/bufferTif/LT.buff/LT.all.BUF.2.tif",1,17,"/disk2/bess/connectivity/locosProces/outCSV/LT.17.all.2.csv")
#processing.alghelp("lecos:patchstatistics")

# METRIC(What to calculate)
#0 - Land cover
#1 - Landscape Proportion
#2 - Edge length
#3 - Edge density
#4 - Number of Patches
#5 - Patch density
#6 - Greatest patch area
#7 - Smallest patch area
#8 - Mean patch area
#9 - Median patch area
#10 - Largest Patch Index
#11 - Fractal Dimension Index
#12 - Mean patch shape ratio
#13 - Mean Shape Index
#14 - Overall Core area
#15 - Like adjacencies
#16 - Patch cohesion index
#17 - Landscape division
#18 - Effective Meshsize
#19 - Splitting Index 

