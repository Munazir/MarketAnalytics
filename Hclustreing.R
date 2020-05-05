#Import the data
seg.data <- read.csv(file = "SegmentationData.csv",row.names = 1)
head(seg.data)
#Data preprocessing
str(seg.data)
dim(seg.data)

#
colnames(seg.data)
