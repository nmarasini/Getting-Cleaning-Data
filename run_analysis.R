# Install Packages if not already installed
# install.packages("plyr")
# install.packages("data.table")
# install.packages("tidyr")


#Load necessary packages
library(plyr)
library(data.table)
library(tidyr)

## Download and unzip dataset 
if (!file.exists("./UCI HAR Dataset")) {
  fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, "Dataset.zip")
  unzip("Dataset.zip") 
}

#Load data files
dataTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
dataTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")

#Load activity files
dataTest_Y<- read.table("./UCI HAR Dataset/test/Y_test.txt")
dataTrain_Y <- read.table("./UCI HAR Dataset/train/Y_train.txt")

#Load subject files
dataTestSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
dataTrainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#1. Merging the training and the test sets to create one data set.
#One data set for X
dataAll_X <- rbind(dataTrain, dataTest)

#One data set for Y
datAll_Y  <- rbind(data_train_Y, data_test_Y)

#One data set for Subject
dataAllSubject <- rbind(data_train_subject, dataTestSubject)

#2. Extract only the measurements on the mean and standard deviation for each measurement.
#Load features.txt file
dataFeatures <- read.table("./UCI HAR Dataset/features.txt")

#Get list of mean and std columns
meanStd <- grep("-(mean|std)\\(\\)", data_features[, 2])

#Subset the mean and std columns
dataAll_X <- dataAll_X[, mean_std]

#Set column names
names(dataAll_X) <- data_features[mean_std, 2]

#3. Use descriptive activity names to name the activities in the data set
#Load activity_labels.txt file
dataActivities <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Update correct activity name
datAll_Y [, 1] <- dataActivities [datAll_Y [, 1], 2]

names(datAll_Y ) <- "activity"

#4. Appropriately label the data set with descriptive variable names
# correct column name
names(dataAllSubject) <- "subject"

# bind all the data in a single data set
allData <- cbind(dataAll_X, datAll_Y , dataAllSubject)

#Update label of the data
names(allData)<-gsub("std()", "SD", names(allData))
names(allData)<-gsub("mean()", "MEAN", names(allData))
names(allData)<-gsub("^t", "time", names(allData))
names(allData)<-gsub("^f", "frequency", names(allData))
names(allData)<-gsub("Acc", "Accelerometer", names(allData))
names(allData)<-gsub("Gyro", "Gyroscope", names(allData))
names(allData)<-gsub("Mag", "Magnitude", names(allData))
names(allData)<-gsub("BodyBody", "Body", names(allData))

#5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
avg <- ddply(allData, .(subject, activity), function(x) colMeans(x[, 1:66]))

#Create tidy data set
write.table(avg, "clean_data.txt", row.name=FALSE)