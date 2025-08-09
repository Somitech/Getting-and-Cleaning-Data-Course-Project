# Getting and Cleaning Data - Course Project
#
# This script takes raw data from the UCI HAR Dataset and transforms it
# into a clean, tidy dataset ready for analysis.

#-------------------------------------------------------------------------------
# Step 0: Setup - Load necessary libraries and data
#-------------------------------------------------------------------------------

# Load the dplyr library for data manipulation
library(dplyr)

# Define the filename for the dataset source
zipFile <- "getdata_projectfiles_UCI HAR Dataset.zip"
dataFolder <- "UCI HAR Dataset"

# Download and unzip the dataset if it doesn't already exist
if (!file.exists(zipFile)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, zipFile, method="curl")
}
if (!file.exists(dataFolder)) {
  unzip(zipFile)
}

# Read the data tables into R
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")


#-------------------------------------------------------------------------------
# Step 1: Merge the training and the test sets to create one data set
#-------------------------------------------------------------------------------

# Combine the rows for each data type
X_data <- rbind(x_train, x_test)
Y_data <- rbind(y_train, y_test)
Subject_data <- rbind(subject_train, subject_test)

# Combine all three data frames by columns to create the full dataset
Full_Data <- cbind(Subject_data, Y_data, X_data)


#-------------------------------------------------------------------------------
# Step 2: Extract only the measurements on the mean and standard deviation
#-------------------------------------------------------------------------------

# Use dplyr's select() to keep the Subject, code, and any column containing "mean" or "std"
TidyData <- Full_Data %>%
  select(Subject, code, contains("mean"), contains("std"))


#-------------------------------------------------------------------------------
# Step 3: Use descriptive activity names to name the activities
#-------------------------------------------------------------------------------

# Replace the numeric activity codes with descriptive names from activity_labels
TidyData$code <- activity_labels[TidyData$code, 2]


#-------------------------------------------------------------------------------
# Step 4: Appropriately label the data set with descriptive variable names
#-------------------------------------------------------------------------------

# Use gsub() to replace abbreviations and clean up the names
names(TidyData)[2] = "Activity" # Rename the 'code' column to 'Activity'
names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody", names(TidyData))
names(TidyData) <- gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("angle", "Angle", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))


#-------------------------------------------------------------------------------
# Step 5: Create a second, independent tidy data set with the average
#         of each variable for each activity and each subject.
#-------------------------------------------------------------------------------

# Group the data by Subject and Activity, then calculate the mean for all other columns
FinalData <- TidyData %>%
  group_by(Subject, Activity) %>%
  summarise_all(mean)

# Write the final tidy dataset to a text file
write.table(FinalData, "TidyData.txt", row.name=FALSE)

# Announce completion
print("Script finished! The final tidy dataset is saved as TidyData.txt")
