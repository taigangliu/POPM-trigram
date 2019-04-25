NameNo <- 1
DataName <- c("ZW225")

cat(DataName[NameNo],"is running...","\n")

library(e1071)

#set working directory
mainDir<-paste("/data/tgliu/program/SubLoc/",DataName[NameNo],"/result/svm-rfe/tenproperties-trigram",sep="")
subDir<-"linear_result_libsvmscale"
dir.create(file.path(mainDir,subDir),showWarnings=FALSE)
setwd(file.path(mainDir,subDir))

#load database
db <- read.table(file=paste("/data/tgliu/program/SubLoc/",DataName[NameNo],"/result/svm-rfe/tenproperties-trigram/sortedFV-libsvmscale",sep=""),header=FALSE)

dim(db)
x = as.matrix(db[,-1])
y = as.factor(db[,1])

y1 = as.numeric(as.character(y)) 

SeqNum <- c(0,0,0,0)
SeqNum[1]=length(y[y==0])
SeqNum[2]=length(y[y==1])
SeqNum[3]=length(y[y==2])
SeqNum[4]=length(y[y==3])

cat("The total number of sequence is: ",sum(SeqNum),"\n")

cat("leave one out test using the best n ranked feature is running...","\n")

# Leave One Out test using the best n ranked features of the SVM-RFE

totalresult="linearResultTop-10-500-10-libsvmscale.txt"
if(file.exists(file.path(mainDir,totalresult))) file.remove(file.path(mainDir,totalresult))

for(p in seq(10,500,10))
{
	resultfilename=paste("Top-",p,".txt",sep="")  
	if(file.exists(resultfilename)) file.remove(resultfilename)
	
  nfeatures = p
	cat("top",nfeatures,"feature is selected.","\n")
  
  truePredictions = 0  
	
	prediction_result <- matrix(rep(0,16),nrow=4)
	Count_right=c(0,0,0,0)
	Count_error=c(0,0,0,0)
	TP=c(0,0,0,0)
	TN=c(0,0,0,0)
	FP=c(0,0,0,0)
	FN=c(0,0,0,0)
		
	Accuracy=c(0,0,0,0)
	MCC=c(0,0,0,0)
	Precision=c(0,0,0,0)
	Specificity=c(0,0,0,0)
	FPR=c(0,0,0,0)
	totalacc=0
	##################################################
  
	for(i in 1:nrow(x))
	{
	  svmModel = svm(x[-i, 1:nfeatures], y[-i], cost = 10, cachesize=500,  scale=F, type="C-classification", kernel="linear" ) 
	  prediction = predict(svmModel,matrix(x[i, 1:nfeatures],nrow=1))
	  
	  prediction1=as.numeric(as.character(prediction[[1]]))
	  
	  prediction_result[y1[i]+1,prediction1+1]=prediction_result[y1[i]+1,prediction1+1]+1
	  
	  if(prediction[[1]] == y[i]) 
	  {
	  	truePredictions = truePredictions + 1
	  	Count_right[y1[i]+1]=Count_right[y1[i]+1]+1
	  }
	  else
	  {
	  	Count_error[prediction1+1]=Count_error[prediction1+1]+1
	  }
	  cat("The ",i," sequence is ok!\n")
	}
	
	for(i in 1:4)
	{
		TP[i]=Count_right[i]
		FP[i]=Count_error[i]
		FN[i]=SeqNum[i]-Count_right[i]
		TN[i]=sum(SeqNum)-SeqNum[i]-Count_error[i]		
		if(TP[i]+FP[i]+FN[i]+TN[i]-sum(SeqNum)==0)
		{
			cat("The ",i," class is right!\n",file=resultfilename,append=TRUE)
		}
		else
		{
			cat("The ",i," class is error!\n",file=resultfilename,append=TRUE)		
		}
	}
	
	for(i in 1:4)
	{
		Accuracy[i]=1.0*Count_right[i]/SeqNum[i]
		Precision[i]=1.0*TP[i]/(TP[i]+FP[i])
		Specificity[i]=1.0*TN[i]/(TN[i]+FP[i])
		FPR[i]=1.0*FP[i]/(TN[i]+FP[i])
		MCC[i]=1.0*(TP[i]*TN[i]-FP[i]*FN[i])/sqrt(1.0*(TP[i]+FP[i])*(TP[i]+FN[i])*(TN[i]+FP[i])*(TN[i]+FN[i]))
		
		cat("The Precision for the", i ,"class is: ",Precision[i],"\n",file=resultfilename,append=TRUE)
		cat("The FPR for the", i ,"class is: ",FPR[i],"\n",file=resultfilename,append=TRUE)
		cat("The Specificity for the", i ,"class is: ",Specificity[i],"\n",file=resultfilename,append=TRUE)	
		cat("The Accuracy for the", i ,"class is: ",Accuracy[i],"\n",file=resultfilename,append=TRUE)
		cat("The MCC for the", i ,"class is: ",MCC[i],"\n",file=resultfilename,append=TRUE)
		
		cat("The Accuracy for the", i ,"class is: ",Accuracy[i],"\n")
	}
	
	totalacc=1.0*sum(Count_right)/sum(SeqNum)
	
	cat("The total accuracy is: :",totalacc,"\n",file=resultfilename,append=TRUE)
	cat("The total accuracy is: :",totalacc,"\n")
	
	for(i in 1:4)
	{
		for(j in 1:4)
		{	
			cat(prediction_result[i,j],"\t",file= resultfilename,append=TRUE)
		}
		cat("\n",file= resultfilename,append=TRUE)
	}

  cat(nfeatures,":",truePredictions/nrow(x),"\n")
  cat(nfeatures,":",truePredictions/nrow(x),"\n",file=file.path(mainDir,totalresult),append=TRUE)  
}

cat("The program is over!\n")





