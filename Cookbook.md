# Getting and Cleaning Data Project

**Author:** Michael Galarnyk

## Description
This document provides additional information about the variables, data, and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

## Source Data
The source data and description can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Data Set Information
The data comes from experiments conducted with a group of 30 volunteers aged 19-48. Each person performed six activities while wearing a smartphone (Samsung Galaxy S II) on their waist. The smartphone's embedded accelerometer and gyroscope captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The dataset was divided into training (70% of volunteers) and test (30% of volunteers) sets.

The sensor signals (accelerometer and gyroscope) underwent pre-processing, including noise filtering and fixed-width sliding window sampling with 50% overlap. A Butterworth low-pass filter was used to separate gravitational and body motion components in the acceleration signal. Features were extracted from both time and frequency domains, resulting in a 561-feature vector for each record. Each record also includes an activity label and an identifier for the subject.

## Attribute Information
For each record in the dataset, the following information is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Activity label.
- Identifier of the subject who carried out the experiment.

## Data Preprocessing Steps
The following steps were taken to prepare and clean the data:

### 1. Merge Data Sets
The training and test data sets were merged into a single data set.

### 2. Extract Relevant Measurements
Only measurements related to mean and standard deviation were extracted from the feature vector.

### 3. Use Descriptive Activity Names
Descriptive activity names replaced the numeric activity labels in the data set.

### 4. Label Variables Appropriately
Descriptive variable names were applied to the data set for clarity.

### 5. Create Tidy Data Set
A second independent tidy data set was created from the cleaned data. This new data set contains the average of each variable for each activity and each subject.

For detailed implementation instructions, refer to the [README.md]

By following these steps, the raw data was transformed into a clean, structured data set suitable for further analysis and modeling.
