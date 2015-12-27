# GettingAndCleaningDataCourseProject

This R script will take the UCI HAR dataset extract all mean and standard deviation data points from the combined test and training data set and create two files from this data. The first is a csv raw file with each activities and all mean and standard deviation columns named UCI_HAR_Combined_Unsumarized.txt. The second takes the mean of all columns from UCI_HAR_Combined_Unsumarized.txt grouped by Subject and Activity.

Variables are described in CodeBook.md

## Requirements
* R Library: dplyr
* Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Running this file
1. Extract the UCI HAR Dataset file to a directory
2. Run run_analysis.r