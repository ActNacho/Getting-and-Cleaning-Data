## Before begin, we need all the downloaded files in a folder named "data" stored in the Working Directory
## setwd("~/R/3. Getting and Cleaning Data/Peer Assessment") 


## 1. Merges the training and the test sets to create one data set.

#Get the TRAINing data
Xtrain <- read.table("./data/train/X_train.txt")
Ytrain <- read.table("./data/train/y_train.txt")
Strain <- read.table("./data/train/subject_train.txt")
#Get the TEST data
Xtest <- read.table("./data/test/X_test.txt")
Ytest <- read.table("./data/test/y_test.txt") 
Stest <- read.table("./data/test/subject_test.txt")
#Merge them together
MergedX <- rbind(Xtrain, Xtest)
MergedY <- rbind(Ytrain, Ytest)
MergedS <- rbind(Strain, Stest)
#Delete variables that will not be used in the future
rm(Xtrain); rm(Ytrain); rm(Strain) 
rm(Xtest); rm(Ytest); rm(Stest) 


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

#Get the proper indexes for the means and stdevs
features <- read.table("./data/features.txt")
meanStdIndex <- grep("mean\\(\\)|std\\(\\)", features[, 2])
#Only keep data from mean or stdev
MergedX <- MergedX[, meanStdIndex]
#Correct the headers display so it removes '()', and '-' and change the functions to UpperCase
names(MergedX) <- gsub("\\(\\)", "", features[meanStdIndex, 2]) # remove "()"
names(MergedX) <- gsub("mean", "Mean", names(MergedX)) # m to UpperCase
names(MergedX) <- gsub("std", "Std", names(MergedX)) # s to UpperCase
names(MergedX) <- gsub("-", "", names(MergedX)) # remove "-" in column names 
#Delete variables that will not be used in the future
rm(features); rm(meanStdIndex)


## 3. Uses descriptive activity names to name the activities in the data set

activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) #Change names to LowerCase
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) #Change Upstairs
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) #Change Downstairs
MergedY[, 1] <- activity[MergedY[, 1], 2]
names(MergedY) <- "activity"


# 4. Appropriately labels the data set with descriptive variable names. 

names(MergedS) <- "subject"
cleanedData <- cbind(MergedS, MergedY, MergedX)
#Delete variables that will not be used in the future
rm(MergedX); rm(MergedY); 


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#The dimmensions of the data set depend on the size of MergedS, activity and cleanedData
SLen <- length(table(MergedS)) 
activityLen <- dim(activity)[1]
colLen <- dim(cleanedData)[2]
result <- as.data.frame(matrix(NA, nrow=SLen*activityLen, ncol=colLen))
colnames(result) <- colnames(cleanedData)
k <- 1
for(i in 1:SLen) {
  for(j in 1:activityLen) {
    #Put subject number (this will be repeated one time for each activity)
    result[k, 1] <- sort(unique(MergedS)[, 1])[i]
    #Put activity (every activity will be assigned once for each subject)
    result[k, 2] <- activity[j, 2]
    # Take the data for the subject
    bool1 <- i == cleanedData$subject
    # Take the activity to be analized
    bool2 <- activity[j, 2] == cleanedData$activity
    # Take all the information for a specific activity and subject, calculate the mean
    result[k, 3:colLen] <- colMeans(cleanedData[bool1&bool2, 3:colLen])
    k <- k + 1
    #In the end we will have k-1 observations in the data set
  }
}
#Delete variables that will not be used in the future
rm(activity); rm(MergedS); rm(SLen); rm(activityLen)
rm(bool1); rm(bool2); rm(colLen); rm(i); rm(j)

#This is going to create the txt file with the data set
write.table(result, "tidy_data_step5.txt", row.name=FALSE) # Creates the txt file requested

#data <- read.table("./tidy_data_step5.txt",header=TRUE) to load the data just created
