#Import the data
segment.data <- read.csv(file = "SegmentationData.csv",row.names = 1)
head(segment.data)

# data preprpcessing
str(segment.data)
dim(segment.data)

#scaling
scaled.data <- scale(segment.data[,c("Trendy","Styling","Reliability","Sportiness","Performance","Comfort")])
head(scaled.data)

#forming dist matrix
dist.data <- dist(scaled.data,method = "euclidean")

#check 5 rows and 5 columns
as.matrix(dist.data)[1:5,1:5]

#h-clustering
data.clusters <- hclust(dist.data,method = "ward.D2")
plot(data.clusters)

#cutting the tree in number of clusters and marking it
h.clusters <- cutree(data.clusters,k = 4)
rect.hclust(data.clusters,k = 4,border = 2)

#frequency table of cluster members
table(h.clusters)

#cluster summary
h.clusters.summary <- aggregate(x = scaled.data,by=list(h.clusters),FUN=mean)
h.clusters.summary

# Appearance driven cluster (checking the members of 3rd cluster)
plot(cut(as.dendrogram(data.clusters),h=9)$lower[[3]])

# choosing number of clusters based on the Nblcust method has 26 criteria to select optimal number of Clusters
pkgs <- c("factoextra",  "NbClust")
install.packages(pkgs)

#importing the libraries
library(factoextra)
library(NbClust)
NbClust(data = scaled.data[,1:5],min.nc = 3,max.nc = 15,index = "all",method = "ward.D2")

#Trying to identify the segments
install.packages("gmodels")
library(gmodels)
CrossTable(segment.data$MBA,h.clusters,prop.r = T,prop.c = T,prop.t = F,prop.chisq = FALSE,chisq = T)

#Comparing the formed driver cluster with the choice available
CrossTable(h.clusters,segment.data$Choice,prop.r = T,prop.c = T,prop.t = F,prop.chisq = FALSE,chisq = T)

     