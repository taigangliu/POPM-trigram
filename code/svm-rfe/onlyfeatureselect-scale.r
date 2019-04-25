NameNo <- 1

DataName <- c("ZW225")

cat(DataName[NameNo],"is running...","\n")

# testing the SVM-RFE algorithm

library(e1071)
source("/data/tgliu/program/SubLoc/MulticlassSVM-RFE.r")

#set working directory
setwd(paste("/data/tgliu/program/SubLoc/",DataName[NameNo],"/result/svm-rfe/tenproperties-trigram",sep=""))

#load database
db <- read.table(file=paste("/data/tgliu/program/SubLoc/",DataName[NameNo],"/result/svm-rfe/tenproperties-trigram/FV-libsvmscale",sep=""),header=FALSE)

dim(db)
x = as.matrix(db[,-1])
y = as.factor(db[,1])

# Feature Ranking with SVM-RFE
cat("feature rank is running...","\n")

featureRankedList = svmrfeFeatureRankingForMulticlass(x,y)
write.table(featureRankedList,file="fvRankedList-libsvmscale.txt",col.names=FALSE,row.names=FALSE)

cat("feature rank is ok!","\n")