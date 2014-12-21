## The goal of this R script is to prepare tidy data that can be used for later analysis.
## the script will do the following:
## 1, Merges the training and the test sets to create one data set.
## 2, Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3, Uses descriptive activity names to name the activities in the data set
## 4, Appropriately labels the data set with descriptive variable names. 
## 5, From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## load dplyr library
library(dplyr)

## Task 1: Merge the training and the test sets to create one data set
## source: the train and test datasets of UCI HAR Dataset
## notes: before executing, extract the zip file to the same directory as this script file

## save the current dir to go back later
olddir <- getwd()
## go to the course project dir
setwd("C:/Temp/DataScience/proj-cleaningdata")

## create train data.frame from the related train dataset, including subject_train, y_train(activity), X_train(features)
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
train <- cbind(sub_train,y_train,x_train)
## create test data.frame from the related test dataset, including subject_test, y_test(activity), X_test(features)
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
test <- cbind(sub_test,y_test,x_test)

## merge train and test dataset to create alldata dataset
alldata <- rbind(train, test)

## Task 4: give the descriptive variable names to alldata dataset
fv <- read.table("UCI HAR Dataset/features.txt")
names(alldata) <- c("Subject","Activity",as.character(fv$V2))

## Task 2: Extracts only the measurements on the mean and standard deviation for each measurement
specdata <- alldata[,grep("Subject|Activity|-mean[^F]|-std[^F]",names(alldata))]

## Task 3:Uses descriptive activity names to name the activities in the data set
act <- read.table("UCI HAR Dataset/activity_labels.txt")
for (i in seq_len(nrow(act))) {
    specdata$Activity <- gsub(as.character(act[i,1]),as.character(act[i,2]),specdata$Activity)    
}

## Task 5:creates a second, independent tidy data set with the average of each variable 
##          for each activity and each subject
specdata_df <- tbl_df(specdata)
avgdata <- specdata_df %>% group_by(Subject, Activity) %>%
    summarise_each(funs(mean))
## write result dataset to resultdata.txt
write.table(avgdata, file="resultdata.txt",row.names=FALSE)

## go back to original dir
setwd(olddir)