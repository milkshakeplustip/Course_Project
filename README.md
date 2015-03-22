# Getting and Cleaning Data Course Project

## Description

The script in 'run_analysis.R' takes the data from the 'Human Activity Recognition Using Smartphones Data Set' and creates an independent tidy data set with the average of each variable for each activity and each subject. A full description of the data is available here: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The specific folder with the data can be obtained here (the zip file):

http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

The script takes the files located within the 'test' and 'train' folders (except the 'Inertial' folders, explained below in Notes), assembles each of them individually through 'cbind' and concatenates them with 'rbind'. It then subsets this table with the measurements on the mean and standard deviation for each measurement (explained below in Decisions) and gives descriptive names to the variables and the six different activities, as specified in 'features.txt' and 'activity_labels.txt'. Finally, it makes use of the package 'dplyr' to group by the different subjects and activities and summarize the data with the means of the other columns.

The data set generated can be used for later analysis and meets the requirements for a tidy data set:

1. Each variable measured has a descriptive name (explained below in Decisions) and is in one column.
2. Each variable's different observation is in a different row and uses descriptive activity names. It can be easily seen that every subject did all of the six activities.

## Decisions

I took two important decisions:

1. The first one has to do with the variables selected from 'features.txt'. I only selected those that represent a specific 'mean' and 'sd' for each of the 17 main signals specified in 'features_info.txt', eight of them broken up in their XYZ components, resulting in 33 values for 'mean' and 33 values for 'sd' (one 'mean' and one 'sd' for each of the 17 main signals, 33 when the XYZ components are considered). Specifically, there are more features that contain the word 'mean' in 'features.txt', but only those that are followed with parenthesis, 'mean()', were selected. The ones that are angles between two quantities, some of them means, are not real means.
2. The second decision is related to the names I gave to the variables. I chose to give them the same names as in the original data set because I consider they already are good, descriptive names (they make it easy to understand which one is a 'mean' and an 'sd' value, and if they are a X, Y, or Z component) and it facilitates the comparison of both data sets.

## Notes

1. A description of each variable is available in 'Codebook.md'.
2. Since only the 'mean' and 'sd' values are required, the 'Inertial' folders within each data set (train and test) were not considered. 
3. The table generated can be read back into R and viewed with:

> data <- read.table("file_path", header = TRUE)

> View(data)


