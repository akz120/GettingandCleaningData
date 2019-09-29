1.run_analysis.R that does the following:

1)Merges the training and the test sets to create one data set.
2)Extracts only the measurements on the mean and standard deviation for each measurement.
3)Uses descriptive activity names to name the activities in the data set
4)Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

2.dataset was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

3.data was assigned to following variables
features <- features.txt
activities <- activity_labels.txt
subject_test <- test/subject_test.txt
x_test <- test/X_test.txt
y_test <- test/y_test.txt
subject_train <- test/subject_train.txt
x_train <- test/X_train.txt
y_train <- test/y_train.txt 

4.The following variables were created via merging
X - merging x_train and x_test using rbind() function
Y - merging y_train and y_test using rbind() function
Subject - merging subject_train and subject_test using rbind() function
Merged_Data - merging Subject, Y and X using cbind() function

5.Extracting the measurements on the mean and standard deviation
TidyData (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

6.independent tidy data set with the average of each variable for each activity and each subject:
FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
