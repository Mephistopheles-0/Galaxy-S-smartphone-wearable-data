# Load necessary libraries
library(data.table)
library(reshape2)

# Check and load required libraries quietly
required_libraries <- c("data.table", "reshape2")
library_check <- sapply(required_libraries, require, character.only = TRUE, quietly = TRUE)

# Create a data directory if it doesn't exist
if (!file.exists("./data")) {
    dir.create("./data")
}

# Define the working directory and the URL for the dataset
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download and unzip the dataset
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# Read activity labels
activity_labels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt"), col.names = c("classLabels", "activityName"))

# Read features (variables)
features <- fread(file.path(path, "UCI HAR Dataset/features.txt"), col.names = c("index", "featureNames"))

# Select only the features related to mean and standard deviation
features_wanted <- grep("(mean|std)\\(\\)", features[, featureNames])
selected_features <- features[features_wanted, featureNames]
selected_features <- gsub('[()]', '', selected_features)

# Load training datasets
train_data <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, features_wanted, with = FALSE]
data.table::setnames(train_data, colnames(train_data), selected_features)

train_activities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt"), col.names = c("Activity"))
train_subjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt"), col.names = c("SubjectNum"))
train_data <- cbind(train_subjects, train_activities, train_data)

# Load test datasets
test_data <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, features_wanted, with = FALSE]
data.table::setnames(test_data, colnames(test_data), selected_features)

test_activities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt"), col.names = c("Activity"))
test_subjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt"), col.names = c("SubjectNum"))
test_data <- cbind(test_subjects, test_activities, test_data)

# Merge training and test datasets
combined_data <- rbind(train_data, test_data)

# Convert classLabels to activityName
combined_data[["Activity"]] <- factor(combined_data[, Activity], levels = activity_labels[["classLabels"]], labels = activity_labels[["activityName"]])

# Convert SubjectNum to a factor
combined_data[["SubjectNum"]] <- as.factor(combined_data[, SubjectNum])

# Reshape the data using melt and dcast
combined_data <- reshape2::melt(data = combined_data, id = c("SubjectNum", "Activity"))
combined_data <- reshape2::dcast(data = combined_data, SubjectNum + Activity ~ variable, fun.aggregate = mean)

# Write the tidy data to a file
data.table::fwrite(x = combined_data, file = "tidyData.txt", quote = FALSE)
