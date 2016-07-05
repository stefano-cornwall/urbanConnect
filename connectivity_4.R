

a.BD=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/BD.17.all.values.txt"))
g.BD=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/BD.17.grass.values.txt"))
s.BD=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/BD.17.shrubs.values.txt"))
t.BD=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/BD.17.trees.values.txt"))

a.LT=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/LT.17.all.values.txt"))
g.LT=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/LT.17.grass.values.txt"))
s.LT=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/LT.17.shrubs.values.txt"))
t.LT=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/LT.17.trees.values.txt"))

a.MK=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/MK.17.all.values.txt"))
g.MK=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/MK.17.grass.values.txt"))
s.MK=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/MK.17.shrubs.values.txt"))
t.MK=as.vector(read.table("/disk2/bess/connectivity/locosProces/functional/MK.17.trees.values.txt"))


## Zoom to 30m 
AXat=c(1,2.5,5,10,15,20,25)
AXwrt=c(0,5,10,20,30,40,50)
AYat=c(0,0.25,0.5,0.75,1.0)
AYwrt=c(0,0.25,0.5,0.75,1)


## COMPARE 2D vs 3D
png("/disk2/bess/connectivity/locosProces/functional/compare_2Dvs3D_35mbuffer.png", width = 1600, height = 800)

nf <- layout(matrix(c(1,2,3,4),2,2,byrow=TRUE), c(2,2), c(1,1), TRUE) 
layout.show(nf) ; par(mar=c(3,5,4,1))
plot(1,1, type="n", axes=F, xlab="", ylab="")
legend(0.8,1.3,c("2D connectivity","3D grass connectivity","3D shrub connectivity","3D tree connectivity"), pch=c(15,15,15,15), pt.cex=c(4,4,4),  cex=2.8,   col = c("antiquewhite4","orange","blue","darkgreen"), bty = "n" )

plot(c(1:25),a.BD[1:25,], type="b", ylim=c(0,1), xaxt="n", yaxt="n", main="Bedford", xlab="", ylab="Connectivity Index", col="antiquewhite4", lwd=3, cex=1.5,cex.lab=1.9, cex.main=1.9, cex.axis=1.4) 
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
axis(2, at=AYat,labels=AYwrt, cex.axis=1.3)
points(c(1:25),g.BD[1:25,],type="b", col="orange",      lwd=3, cex=1.5)
points(c(1:25),s.BD[1:25,],type="b", col="blue",      lwd=3, cex=1.5)
points(c(1:25),t.BD[1:25,],type="b", col="darkgreen",  lwd=3, cex=1.5)
# legend(10,0.9,c("2D connectivity","3D grass","3D shrubs","3D trees"), pch=c(15,15,15,15), pt.cex=c(2,2,2),  cex=1.8,   col = c("black","green","brown","darkgreen"), bty = "n" )

par(mar=c(5,5,4,1))
plot(c(1:25),a.LT[1:25,], type="b", xaxt="n",yaxt="n",  main="Luton", xlab="Dispersal capacity (m)", ylab="Connectivity Index",  col="antiquewhite4", lwd=3, cex=1.5, cex.lab=1.9, cex.main=1.9, cex.axis=1.4)  
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
axis(2, at=AYat,labels=AYwrt, cex.axis=1.3)
points(c(1:25),g.LT[1:25,],type="b", col="orange",     lwd=3, cex=1.5)
points(c(1:25),s.LT[1:25,],type="b", col="blue",     lwd=3, cex=1.5)
points(c(1:25),t.LT[1:25,],type="b", col="darkgreen", lwd=3, cex=1.5)


par(mar=c(5,5,4,1))
plot(c(1:25),a.MK[1:25,], type="b", xaxt="n", yaxt="n", main="Milton Keynes", xlab="Dispersal capacity (m)", ylab="", col="antiquewhite4", lwd=3, cex=1.5 ,cex.lab=1.9, cex.main=1.9, cex.axis=1.4)
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
axis(2, at=AYat,labels=AYwrt, cex.axis=1.3)
points(c(1:25),g.MK[1:25,],type="b", col="orange",   lwd=3, cex=1.5)
points(c(1:25),s.MK[1:25,],type="b", col="blue",  lwd=3, cex=1.5)
points(c(1:25),t.MK[1:25,],type="b", col="darkgreen",  lwd=3, cex=1.5)
dev.off()


## COMPARE TOWNS
png("/disk2/bess/connectivity/locosProces/functional/compare_town_35mbuffer.png", width = 1600, height = 800)
nf <- layout(matrix(c(1,2,3,4),2,2,byrow=TRUE), c(2,2), c(1,1), TRUE) 
layout.show(nf) ; par(mar=c(3,5,4,1))

plot(c(1:25),a.BD[1:25,], type="b", ylim=c(0,1), xaxt="n", yaxt="n", main="All vegetation strata", xlab="", ylab="Connectivity Index",  cex=1.5,cex.lab=1.9, cex.main=1.9, cex.axis=1.4) 
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
axis(2, at=AYat,labels=AYwrt, cex.axis=1.3)
points(c(1:25),a.LT[1:25,],type="b", col="red",  cex=1.5)
points(c(1:25),a.MK[1:25,],type="b", col="blue",  cex=1.5)
legend(10,0.9,c("Bedford","Luton","Milton Keynes"), pch=c(15,15,15,15), pt.cex=c(2,2,2),  cex=1.8,   col = c("black","red","blue"), bty = "n" )

par(mar=c(3,5,4,1))
plot(c(1:25),g.BD[1:25,], type="b", xaxt="n",yaxt="n",  main="Grass", xlab="", ylab="",  cex=1.5, cex.lab=1.9, cex.main=1.9, cex.axis=1.4)  
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
axis(2, at=AYat,labels=AYwrt, cex.axis=1.3)
points(c(1:25),g.LT[1:25,],type="b", col="red",  cex=1.5)
points(c(1:25),g.MK[1:25,],type="b", col="blue",  cex=1.5)
legend(20,0.9,c("Bedford","Luton","Milton Keynes"), pch=c(15,15,15,15), pt.cex=c(2,2,2),  cex=1.8,   col = c("black","red","blue"), bty = "n" )

par(mar=c(5,5,4,1))
plot(c(1:25),s.BD[1:25,], type="b", xaxt="n", yaxt="n", main="Shrubs", xlab="Dispersal capacity (m)", ylab="Connectivity Index",  cex=1.5 ,cex.lab=1.9, cex.main=1.9, cex.axis=1.4)
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
axis(2, at=AYat,labels=AYwrt, cex.axis=1.3)
points(c(1:25),s.LT[1:25,],type="b", col="red",  cex=1.5)
points(c(1:25),s.MK[1:25,],type="b", col="blue",  cex=1.5)
legend(20,0.9,c("Bedford","Luton","Milton Keynes"), pch=c(15,15,15,15), pt.cex=c(2,2,2),  cex=1.8,   col = c("black","red","blue"), bty = "n" )
par(mar=c(5,5,4,1))
plot(c(1:25),t.BD[1:25,], type="b", xaxt="n", yaxt="n", main="Trees", xlab="Dispersal capacity (m)", ylab="",  cex=1.5 ,cex.lab=1.9, cex.main=1.9, cex.axis=1.4)
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
axis(2, at=AYat,labels=AYwrt, cex.axis=1.3)
points(c(1:25),t.LT[1:25,],type="b", col="red",  cex=1.5)
points(c(1:25),t.MK[1:25,],type="b", col="blue",  cex=1.5)
legend(20,0.9,c("Bedford","Luton","Milton Keynes"), pch=c(15,15,15,15), pt.cex=c(2,2,2),  cex=1.8,   col = c("black","red","blue"), bty = "n" )
dev.off()


## COMPARE TOWNS from 0-50m buffer
AXat=c(5,10,20,30,40,50,60)
AXwrt=c(10,20,40,60,80,100,120)
png("/disk2/bess/connectivity/locosProces/functional/compare_town.png", width = 800, height = 800)
nf <- layout(matrix(c(1,2,3,4),2,2,byrow=TRUE), c(1,1), c(1,1), TRUE) 
layout.show(nf) ; par(mar=c(5,5,5,1))

plot(c(1:50),a.BD[1:50,], type="b", xaxt="n", main="All vegetation strata", xlab="Dispersal capacity (m)", ylab="Connectivity index (Prob. not connected)",  cex=1.5,cex.lab=1.4, cex.main=1.7, cex.axis=1.4) 
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
points(c(1:50),a.LT[1:50,],type="b", col="red",  cex=1.5)
points(c(1:50),a.MK[1:50,],type="b", col="blue",  cex=1.5)
legend(20,0.9,c("Bedford","Luton","Milton Keynes"), pch=c(15,15,15,15), pt.cex=c(2,2,2),  cex=1.8,   col = c("black","red","blue"), bty = "n" )

plot(c(1:50),g.BD[1:50,], type="b", xaxt="n", main="Grass", xlab="Dispersal capacity (m)", ylab="Connectivity index (Prob. not connected)",  cex=1.5, cex.lab=1.4, cex.main=1.7, cex.axis=1.4)  
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
points(c(1:50),g.LT[1:50,],type="b", col="red",  cex=1.5)
points(c(1:50),g.MK[1:50,],type="b", col="blue",  cex=1.5)
legend(20,0.9,c("Bedford","Luton","Milton Keynes"), pch=c(15,15,15,15), pt.cex=c(2,2,2),  cex=1.8,   col = c("black","red","blue"), bty = "n" )

plot(c(1:50),s.BD[1:50,], type="b", xaxt="n", main="Shrubs", xlab="Dispersal capacity (m)", ylab="Connectivity index (Prob. not connected)",  cex=1.5 ,cex.lab=1.4, cex.main=1.7, cex.axis=1.4)
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
points(c(1:50),s.LT[1:50,],type="b", col="red",  cex=1.5)
points(c(1:50),s.MK[1:50,],type="b", col="blue",  cex=1.5)
legend(20,0.9,c("Bedford","Luton","Milton Keynes"), pch=c(15,15,15,15), pt.cex=c(2,2,2),  cex=1.8,   col = c("black","red","blue"), bty = "n" )

plot(c(1:50),t.BD[1:50,], type="b", xaxt="n", main="Trees", xlab="Dispersal capacity (m)", ylab="Connectivity index (Prob. not connected)",  cex=1.5 ,cex.lab=1.4, cex.main=1.7, cex.axis=1.4)
axis(1, at=AXat,labels=AXwrt, cex.axis=1.5)
points(c(1:50),t.LT[1:50,],type="b", col="red",  cex=1.5)
points(c(1:50),t.MK[1:50,],type="b", col="blue",  cex=1.5)
legend(20,0.9,c("Bedford","Luton","Milton Keynes"), pch=c(15,15,15,15), pt.cex=c(2,2,2),  cex=1.8,   col = c("black","red","blue"), bty = "n" )
dev.off()

