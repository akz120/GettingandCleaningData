#Preparation part:
#1.download file&unzip the file
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="data\\Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#2.to see the list of the files in the created folder:
path<- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)
files

#3.to read the files we need we assign them in the following way
ActivityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)
SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
FeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
FeaturesNames <- read.table(file.path(path, "features.txt"  ),header = FALSE)
ActivityLabels <- read.table(file.path(path, "activity_labels.txt"  ),header = FALSE) 

#4. assinging the column names
colnames(ActivityTest) <- 'Activity'
colnames(ActivityTrain) <- 'Activity'
colnames(SubjectTest) <- 'Subject'
colnames(SubjectTrain ) <- 'Subject'
colnames(FeaturesTest ) <-  FeaturesNames$V2
colnames(FeaturesTrain) <- FeaturesNames$V2
colnames(ActivityLabels ) <-c('Activity','ActivityDescription')

#5.Creating one dataset vie merging the sets 'train' and 'test'
Train<-cbind(SubjectTrain,ActivityTrain,FeaturesTrain)
Test<-cbind(SubjectTest,ActivityTest,FeaturesTest )
data<-rbind(Train, Test)

#6.In order to get the measurements on the mean and standard deviation for each measurement:
data<-data[,c(1,2,grep("mean\\(\\)|std\\(\\)",names(data)))]

#7.Uses descriptive activity names to name the activities in the data set
data<-merge(data,ActivityLabels,'Activity')

#8 Sorting
data<-data[,-1]
#reordering columns 
data <- data[c(1,68,2:67)]
#ordering by subject, ActivityDescription
data<-data[order(data$Subject,data$ActivityDescription),]

#9.Appropriately labels the data set with descriptive variable names
names(data) <- gsub("\\(\\)", "", names(data)) 
names(data) <- gsub("mean", "Mean",  names(data)) 
names(data) <- gsub("std", "Std", names(data)) 
names(data) <- gsub("-", "",  names(data))

#10. Writing cleaned file 
write.table(data, "cleandata.txt") 

#11.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data2<-aggregate(. ~data$Subject+data$ActivityDescription, data[, 3:68], mean)
write.table(data2, file = "tidydata.txt",row.name=FALSE)