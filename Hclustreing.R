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

