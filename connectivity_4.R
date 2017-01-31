# Load data
a.BD=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/BD.17.all.values.txt"))
g.BD=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/BD.17.grass.values.txt"))
s.BD=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/BD.17.shrubs.values.txt"))
t.BD=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/BD.17.trees.values.txt"))

a.LT=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/LT.17.all.values.txt"))
g.LT=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/LT.17.grass.values.txt"))
s.LT=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/LT.17.shrubs.values.txt"))
t.LT=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/LT.17.trees.values.txt"))

a.MK=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/MK.17.all.values.txt"))
g.MK=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/MK.17.grass.values.txt"))
s.MK=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/MK.17.shrubs.values.txt"))
t.MK=as.vector(read.table("/media/ste/backup/bess/connectivity/locosProces/functional/MK.17.trees.values.txt"))


## Figure 3. 
#COMPARE 2D vs 3D
# Zoom to 40m only
AXat= c(1,2,3,4,5,6,8,10,15,20)
AXwrt=c(0,4,6,8,10,12,16,20,30,40)
AYat=c(0,0.25,0.5,0.75,1.0)
AYwrt=c(0,0.25,0.5,0.75,1)
# Plot legend
tiff("/media/ste/backup/bess/connectivity/output_figures/figure3_legend.tiff", width = 800, height = 60)
par(mar=c(0,0,0,0))
plot(c(1:2),c(1:2), type="n", axes=F, xlab="", ylab="")
legend(1,2,c("2D greencover ","Grass layer","Shrub layer","Tree layer"), horiz = TRUE, pch=c(15,15,15,15), pt.cex=c(4,4,4,4),  cex=2,   col = c("antiquewhite4","orange","blue","darkgreen"), bty = "n" )
dev.off()

#Plot data
AX=1.9
tiff("/media/ste/backup/bess/connectivity/output_figures/figure_3.tiff", width = 800, height = 1200)
nf <- layout(matrix(c(1,4,2,5,3,6),3,2,byrow=TRUE), c(1,1), c(1,1), TRUE) ; layout.show(nf) ; par(mar=c(4,6,4,1))
plot(c(1:20),a.MK[1:20,], type="b",  ylim=c(0,1), xaxt="n", yaxt="n", main="Milton Keynes", xlab="", ylab="Connectivity Index", col="antiquewhite4", lwd=3, cex=1.5 , cex.lab=2.9, cex.main=2.9, cex.axis=1.4)
axis(1, at=AXat,labels=AXwrt, cex.axis=AX)
axis(2, at=AYat,labels=AYwrt, cex.axis=AX)
points(c(1:20),g.MK[1:20,],type="b", col="orange",   lwd=3, cex=1.5)
points(c(1:20),s.MK[1:20,],type="b", col="blue",  lwd=3, cex=1.5)
points(c(1:20),t.MK[1:20,],type="b", col="darkgreen",  lwd=3, cex=1.5)
text(18,0.9,labels="a",cex=4)
abline(h=0.15, lty=2)
par(mar=c(4,6,4,1))
plot(c(1:20),a.BD[1:20,], type="b", ylim=c(0,1), xaxt="n", yaxt="n", main="Bedford", xlab="", ylab="Connectivity Index", col="antiquewhite4", lwd=3, cex=1.5, cex.lab=2.9, cex.main=2.9, cex.axis=1.4) 
axis(1, at=AXat,labels=AXwrt, cex.axis=AX)
axis(2, at=AYat,labels=AYwrt, cex.axis=AX)
points(c(1:20),g.BD[1:20,],type="b", col="orange",      lwd=3, cex=1.5)
points(c(1:20),s.BD[1:20,],type="b", col="blue",      lwd=3, cex=1.5)
points(c(1:20),t.BD[1:20,],type="b", col="darkgreen",  lwd=3, cex=1.5)
text(18,0.9,labels="c",cex=4)
abline(h=0.15, lty=2)
par(mar=c(5,6,4,1))
plot(c(1:20),a.LT[1:20,], type="b",  ylim=c(0,1), xaxt="n", yaxt="n",  main="Luton", xlab="Dispersal capacity (m)", ylab="Connectivity Index",  col="antiquewhite4", lwd=3, cex=1.5, cex.lab=2.9, cex.main=2.9, cex.axis=1.4)  
axis(1, at=AXat,labels=AXwrt, cex.axis=AX)
axis(2, at=AYat,labels=AYwrt, cex.axis=AX)
points(c(1:20),g.LT[1:20,],type="b", col="orange",     lwd=3, cex=1.5)
points(c(1:20),s.LT[1:20,],type="b", col="blue",     lwd=3, cex=1.5)
points(c(1:20),t.LT[1:20,],type="b", col="darkgreen", lwd=3, cex=1.5)
text(18,0.9,labels="e",cex=4)
abline(h=0.15, lty=2)
par(mar=c(4,6,4,1))
plot(c(1:20),g.MK[1:20,]-a.MK[1:20,], type="b",  ylim=c(0,1), xaxt="n", yaxt="n", main="Milton Keynes", xlab="", ylab="Difference to 2D connectivity", col="orange", lwd=3, cex=1.5 ,cex.lab=2.9, cex.main=2.9, cex.axis=1.4)
axis(1, at=AXat,labels=AXwrt, cex.axis=AX)
axis(2, at=AYat,labels=AYwrt, cex.axis=AX)
points(c(1:20),s.MK[1:20,]-a.MK[1:20,],type="b", col="blue",  lwd=3, cex=1.5)
points(c(1:20),t.MK[1:20,]-a.MK[1:20,],type="b", col="darkgreen",  lwd=3, cex=1.5)
text(18,0.9,labels="b",cex=4)
par(mar=c(4,6,4,1))
plot(c(1:20),g.BD[1:20,]-a.BD[1:20,], type="b", ylim=c(0,1), xaxt="n", yaxt="n", main="Bedford", xlab="", ylab="Difference to 2D connectivity", col="orange", lwd=3, cex=1.5,cex.lab=2.9, cex.main=2.9, cex.axis=1.4) 
axis(1, at=AXat,labels=AXwrt, cex.axis=AX)
axis(2, at=AYat,labels=AYwrt, cex.axis=AX)
points(c(1:20),s.BD[1:20,]-a.BD[1:20,],type="b", col="blue",      lwd=3, cex=1.5)
points(c(1:20),t.BD[1:20,]-a.BD[1:20,],type="b", col="darkgreen",  lwd=3, cex=1.5)
text(18,0.9,labels="d",cex=4)
par(mar=c(5,6,4,1))
plot(c(1:20),g.LT[1:20,]-a.LT[1:20,], type="b", ylim=c(0,1), xaxt="n",yaxt="n",  main="Luton", xlab="Dispersal capacity (m)", ylab="Difference to 2D connectivity",  col="orange", lwd=3, cex=1.5, cex.lab=2.9, cex.main=2.9, cex.axis=1.4)  
axis(1, at=AXat,labels=AXwrt, cex.axis=AX)
axis(2, at=AYat,labels=AYwrt, cex.axis=AX)
points(c(1:20),s.LT[1:20,]-a.LT[1:20,],type="b", col="blue",     lwd=3, cex=1.5)
points(c(1:20),t.LT[1:20,]-a.LT[1:20,],type="b", col="darkgreen", lwd=3, cex=1.5)
text(18,0.9,labels="f",cex=4)
dev.off()

##Figure 2
## Plot garden density per strata 
library(ggplot2)
MY.df=data.frame(Layer=rep(c("2D","Grass","Shrub","Tree"),3))
MY.df$Town=c("Milton Keynes","Milton Keynes","Milton Keynes","Milton Keynes","Bedford","Bedford","Bedford","Bedford","Luton","Luton","Luton","Luton")
MY.df$Garden=c(13,56,81,29,7,43,60,20,5,40,53,21)
MY.df$Landscape=c(56,26,12,18,46,25,10,12,41,21,10,10)
MY.df$LPI=c(2.9,1.8,0.07,0.59,7.1,1.1,0.08,0.3,2.7,1.26,0.07,0.36)
MY.df$connect=c(0.6770,0.9456,0.9998,0.9895,0.1519,0.9386,0.9996,0.9948,0.7542,0.9520,0.9997,0.9967)
MY.df$connect=c(0.996770,0.999456,0.999998,0.999895,0.991519,0.999386,0.999996,0.999948,0.997542,0.999520,0.999997,0.999967)*100-99
# MY.df$connect=(max-c(0.996770,0.999456,0.999998,0.999895,0.991519,0.999386,0.999996,0.999948,0.997542,0.999520,0.999997,0.999967))*100

ATiY=35
ATX=38
ATY=25

tiff("/media/ste/backup/bess/connectivity/output_figures/GreenCover.tiff", width = 800, height = 800)
ggplot(MY.df, aes(Town, Landscape ,fill=Layer ) ) + geom_bar(stat="identity", position = "dodge") + scale_fill_manual(values=c("antiquewhite4","orange","blue","darkgreen")) +  labs(  y = "Landscape proportion") + labs(  x = "") + ggtitle("Green cover (a)") + 
theme(axis.title.x=element_blank(), axis.title.y=element_text(size=ATiY,face="bold"), axis.text.x=element_text(size=ATX),axis.text.y=element_text(size=ATY),legend.text=element_text(size=18),legend.title=element_text(size=18) , plot.title = element_text(size=40, lineheight=.9, face="bold") ) + guides(fill=FALSE)
dev.off()

tiff("/media/ste/backup/bess/connectivity/output_figures/Fragmentation.tiff", width = 800, height = 800)
ggplot(MY.df, aes(Town, Garden ,fill=Layer ) ) + geom_bar(stat="identity", position = "dodge") + scale_fill_manual(values=c("antiquewhite4","orange","blue","darkgreen")) +  labs(  y = "Small patch index") + labs(  x = "") + ggtitle("Fragmentation (b)") +
theme(axis.title.x=element_blank(), axis.title.y=element_text(size=ATiY,face="bold"), axis.text.x=element_text(size=ATX),axis.text.y=element_text(size=ATY),legend.text=element_text(size=18),legend.title=element_text(size=18) , plot.title = element_text(size=40, lineheight=.9, face="bold") )+ guides(fill=FALSE)
dev.off()

tiff("/media/ste/backup/bess/connectivity/output_figures/CoreArea.tiff", width = 800, height = 800)
ggplot(MY.df, aes(Town, LPI ,fill=Layer ) ) + geom_bar(stat="identity", position = "dodge") + scale_fill_manual(values=c("antiquewhite4","orange","blue","darkgreen")) +  labs(  y = "Largest patch index") + labs(  x = "") + ggtitle("Core area (c)") +
theme(axis.title.x=element_blank(), axis.title.y=element_text(size=ATiY,face="bold"), axis.text.x=element_text(size=ATX),axis.text.y=element_text(size=ATY),legend.text=element_text(size=18),legend.title=element_text(size=18) , plot.title = element_text(size=40, lineheight=.9, face="bold") )+ guides(fill=FALSE)
dev.off()

tiff("/media/ste/backup/bess/connectivity/output_figures/Connectivity.tiff", width = 800, height = 800)
ggplot(MY.df, aes(Town, connect ,fill=Layer ) ) + geom_bar(stat="identity", position = "dodge") + scale_fill_manual(values=c("antiquewhite4","orange","blue","darkgreen")) +  labs(  y = "Connectivity index") + labs(  x = "") + ggtitle("Connectivity (d)") + 
theme(axis.title.x=element_blank(), axis.title.y=element_text(size=ATiY,face="bold"), axis.text.x=element_text(size=ATX),axis.text.y=element_text(size=ATY),legend.text=element_text(size=28),legend.title=element_text(size=18) , plot.title = element_text(size=40, lineheight=.9, face="bold") ) + guides(fill=FALSE)
dev.off()


tiff("/media/ste/backup/bess/connectivity/output_figures/figure_2_legend.tiff", width = 1600, height = 120)
par(mar=c(0,0,0,0))
plot(c(1:2),c(1:2), type="n", axes=F, xlab="", ylab="")
legend(1,2,c("2D greencover ","Grass layer","Shrub layer","Tree layer"), horiz = TRUE, pch=c(15,15,15,15), pt.cex=c(8,8,8,8),  cex=3.8,   col = c("antiquewhite4","orange","blue","darkgreen"), bty = "n" )
dev.off()

tiff("/media/ste/backup/bess/connectivity/output_figures/figure_1_legend.tiff", width = 2400, height = 180)
par(mar=c(0,0,0,0))
plot(c(1:2),c(1:2), type="n", axes=F, xlab="", ylab="")
legend(1,2,c("2D greencover ","Grass layer","Shrub layer","Tree layer"), horiz = TRUE, pch=c(15,15,15,15), pt.cex=c(10,10,10,10),  cex=5.5,   col = c("antiquewhite4","orange","blue","darkgreen"), bty = "n" )
dev.off()

