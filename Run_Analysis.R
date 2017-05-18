# Load the data and unzip the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(url, "getdata_dataset.zip")
unzip("getdata_dataset.zip")


# Merges the training and the test sets to create one data set.
XTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
XTest <- read.table("UCI HAR Dataset/test/X_test.txt")
XTotal <- rbind (XTest, XTrain)

YTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
YTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
YTotal <- rbind (YTest, YTrain)

SubTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
SubTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
SubTotal <- rbind (SubTest, SubTrain)

Activities <- read.table("UCI HAR Dataset/activity_labels.txt")
Features <- read.table("UCI HAR Dataset/features.txt")

# Extract only the measurements on the mean and standard deviation for each measurement

M_STD_Features <- grep("-(mean|std)\\(\\)", features[, 2])

XTotal <- XTotal[, M_STD_Features]
YTotal[, 1] <- Activities[YTotal [, 1], 2]


# Appropriately label the data set with descriptive variable names

names(YTotal) <- "Activity"
names(SubTotal) <- "Subject"

# creates an independent tidy data set with the average of each variable for each activity 
# and each subject.

Full_Data <- cbind (XTotal, YTotal, SubTotal)
TidyData <- ddply(Full_Data, .(Subject, Activity), function(x) colMeans(x[, 1:66]))

