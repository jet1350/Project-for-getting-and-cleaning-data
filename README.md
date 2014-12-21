### Introduction
The goal of this R script is to prepare tidy data that can be used for later analysis.
the script will do the following:
 1, Merges the training and the test sets to create one data set.
 2, Extracts only the measurements on the mean and standard deviation for each measurement. 
 3, Uses descriptive activity names to name the activities in the data set
 4, Appropriately labels the data set with descriptive variable names. 
 5, From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Main Implementation and Steps
Preparation:
 - load dplyr library for the group_by() and summarise_each()

Task 1:
 - Merge the training and the test sets to create one data set
 - source: the train and test datasets of UCI HAR Dataset
 - notes: before executing, extract the zip file to the same directory as this script file

The main steps:
 - save the current dir for going back later, then switch to project directory
        "C:/Temp/DataScience/proj-cleaningdata"
 - create train data.frame from the related train dataset, including subject_train, y_train(activity), X_train(features). read.table() and cbind() is used for getting raw data.
 - create test data.frame from the related test dataset, including subject_test, y_test(activity), X_test(features). 
 - merge train and test dataset to create alldata dataset by rbind()

Task 4:
 - For easier reading and processing later, give the descriptive variable names to alldata dataset now, which implement task 4.

Task 2: 
 - Extracts only the measurements on the mean and standard deviation for each measurement

Task 3:
 - Uses descriptive activity names to name the activities in the data set by using gsub() and for iteration base on activity_labels.txt

Task 5:
 - creates a second, independent tidy data set with the average of each variable. In this step, dplyr functions is used for easier implement and understanding.
 - write result dataset to resultdata.txt
