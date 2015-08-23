# Read all test and train data in UCI HAR Dataset folder.

subjecttest=read.table("UCI HAR Dataset/test/subject_test.txt")
xtest=read.table("UCI HAR Dataset/test/X_test.txt")
ytest=read.table("UCI HAR Dataset/test/y_test.txt")
subjecttrain=read.table("UCI HAR Dataset/train/subject_train.txt")
xtrain=read.table("UCI HAR Dataset/train/X_train.txt")
ytrain=read.table("UCI HAR Dataset/train/y_train.txt")

# Merge 6 datasets into one data set.

mergedtest=cbind(subjecttest,ytest,xtest)
mergedtrain=cbind(subjecttrain,ytrain,xtrain)
alldata=rbind(mergedtest,mergedtrain)

# Extract only variables that are means and standard deviations.

meanstdev=c(1:8,43:48,83:88,123:128,163:168,203,204,216,217,229,230,242,243,
            255,256,268:273,296:298,347:352,375:377,426:431,454:456,505,506,
            515,518,519,528,531,532,541,544,545,554)
selectdata=alldata[,meanstdev]

# Replace activity code numbers with activity names.

selectdata$V1.1[selectdata$V1.1==1]= "Walking"
selectdata$V1.1[selectdata$V1.1==2]= "Walking_Upstairs"
selectdata$V1.1[selectdata$V1.1==3]= "Walking_Downstairs"
selectdata$V1.1[selectdata$V1.1==4]= "Sitting"
selectdata$V1.1[selectdata$V1.1==5]= "Standing"
selectdata$V1.1[selectdata$V1.1==6]= "Laying"

# Change variable names.

cols = c("Subject","Activity","tBodyAcc X-Mean","tBodyAcc Y-Mean","tBodyAcc Z-Mean",
         "tBodyAcc X-StDev","tBodyAcc Y-StDev","tBodyAcc Z-StDev","tGravityAcc X-Mean",
         "tGravityAcc Y-Mean","tGravityAcc Z-Mean","tGravityAcc X-StDev","tGravityAcc Y-StDev",
         "tGravityAcc Z-StDev","tBodyAccJerk X-Mean","tBodyAccJerk Y-Mean","tBodyAccJerk Z-Mean",
         "tBodyAccJerk X-StDev","tBodyAccJerk Y-StDev","tBodyAccJerk Z-StDev","tBodyGyro X-Mean",
         "tBodyGyro Y-Mean","tBodyGyro Z-Mean","tBodyGyro X-StDev","tBodyGyro Y-StDev",
         "tBodyGyro Z-StDev","tBodyGyroJerk X-Mean","tBodyGyroJerk Y-Mean",
         "tBodyGyroJerk Z-Mean","tBodyGyroJerk X-StDev","tBodyGyroJerk Y-StDev",
         "tBodyGyroJerk Z-StDev","tBodyAccMag Mean","tBodyAccMag StDev","tGravityAccMag Mean",
         "tGravityAccMag StDev","tBodyAccJerkMag Mean","tBodyAccJerkMag StDev","tBodyGyroMag Mean",
         "tBodyGyroMag StDev","tBodyGyroJerkMag Mean","tBodyGyroJerkMag StDev",
         "fBodyAcc X-Mean","fBodyAcc Y-Mean","fBodyAcc Z-Mean","fBodyAcc X-StDev",
         "fBodyAcc Y-StDev","fBodyAcc Z-StDev","fBodyAcc X-MeanFreq","fBodyAcc Y-MeanFreq",
         "fBodyAcc Z-MeanFreq","fBodyAccJerk X-Mean","fBodyAccJerk Y-Mean","fBodyAccJerk Z-Mean",
         "fBodyAccJerk X-StDev","fBodyAccJerk Y-StDev","fBodyAccJerk Z-StDev",
         "fBodyAccJerk X-MeanFreq","fBodyAccJerk Y-MeanFreq","fBodyAccJerk Z-MeanFreq",
         "fBodyGyro X-Mean","fBodyGyro Y-Mean","fBodyGyro Z-Mean","fBodyGyro X-StDev",
         "fBodyGyro Y-StDev","fBodyGyro Z-StDev","fBodyGyro X-MeanFreq","fBodyGyro Y-MeanFreq",
         "fBodyGyro Z-MeanFreq","fBodyAccMag Mean","fBodyAccMag StDev","fBodyAccMag MeanFreq",
         "fBodyBodyAccJerkMag Mean","fBodyBodyAccJerkMag StDev","fBodyBodyAccJerkMag MeanFreq",
         "fBodyBodyGyroMag Mean","fBodyBodyGyroMag StDev","fBodyBodyGyroMag MeanFreq",
         "fBodyBodyGyroJerkMag Mean","fBodyBodyGyroJerkMag StDev","fBodyBodyGyroJerkMag MeanFreq")
colnames(selectdata)=cols

# Create new data frame with the average of each variable for each subject and each activity.

library(dplyr)
groupeddata=group_by(selectdata,Subject,Activity)
sumdata=summarise_each(groupeddata,funs(mean))

# Outputs the created data frame to the working directory as a txt file.
write.table(sumdata,file="summarized_data.txt",row.names=FALSE)
