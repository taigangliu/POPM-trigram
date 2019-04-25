
NameNo <- 1

DataName <- c("ZW225")

cat(DataName[NameNo],"is running...","\n")

#set working directory
setwd(paste("/data/tgliu/program/SubLoc/",DataName[NameNo],"/result/svm-rfe/tenproperties-trigram",sep=""))

#load database
db <- read.table(file=paste("/data/tgliu/program/SubLoc/",DataName[NameNo],"/result/svm-rfe/tenproperties-trigram/FV-libsvmscale",sep=""),header=FALSE)
dim(db)

#load rankedfvlist
ranklist <- read.table(file=paste("/data/tgliu/program/SubLoc/",DataName[NameNo],"/result/svm-rfe/tenproperties-trigram/fvRankedList-libsvmscale.txt",sep=""),header=FALSE)

ranklist <- as.vector(ranklist[,1])

db2 <- db[,-1]
db2 <- db2[,ranklist]
dim(db2)
db2 <- cbind(db[,1],db2)
dim(db2)

write.table(db2,file="sortedFV-libsvmscale",col.names=FALSE,row.names=FALSE)


cat("The program is over!","\n")