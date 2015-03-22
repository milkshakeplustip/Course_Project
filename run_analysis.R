## The following code takes the data from the 'Human Activity Recognition Using
## Smartphones Data Set' and creates an independent tidy data set with the
## average of each variable for each activity and each subject.

## 1) Merge the training and test sets to create one data set.

        # Setting to their specific directories and reading the tables.

        setwd("/Users/Javier/Desktop/UCI HAR Dataset/test/")
        test_x <- read.table("X_test.txt", header = 0)
        test_y <- read.table("y_test.txt", header = 0)
        test_subject <- read.table("subject_test.txt", header = 0)

        setwd("/Users/Javier/Desktop/UCI HAR Dataset/train/")
        train_x <- read.table("X_train.txt", header = 0)
        train_y <- read.table("y_train.txt", header = 0)
        train_subject <- read.table("subject_train.txt", header = 0)

        # Working with the 'test' components of the data, assembling them like 
        # LEGO bricks.

        test_subject_activity <- cbind(test_subject, test_y)
        names(test_subject_activity) <- c("Subject", "Activity")
        test_final <- cbind(test_subject_activity, test_x)
        
        # Working with the 'train' components of the data, assembling them like 
        # LEGO bricks.
        
        train_subject_activity <- cbind(train_subject, train_y)
        names(train_subject_activity) <- c("Subject", "Activity")
        train_final <- cbind(train_subject_activity, train_x)
        
        # Concatenating both data sets.
        
        test_train <- rbind(test_final, train_final)

## 2) Extracting only the measurements on the mean and standard deviation for 
##      each measurement. 

        mean_std <- c("Subject","Activity","V1","V2","V3","V4","V5","V6","V41",
                      "V42","V43","V44","V45","V46","V81","V82","V83","V84",
                      "V85","V86","V121","V122","V123","V124","V125","V126",
                      "V161","V162","V163","V164","V165","V166","V201","V202",
                      "V214","V215","V227","V228","V240","V241","V253","V254",
                      "V266","V267","V268","V269","V270","V271","V345","V346",
                      "V347","V348","V349","V350","V424","V425","V426","V427",
                      "V428","V429","V503","V504","V516","V517","V529","V530",
                      "V542","V543")
        mean_std_subset <- test_train[mean_std]

## 3) Using descriptive activity names to name the activities in the data set.

        mean_std_subset$Activity[mean_std_subset$Activity == "1"] <- "Walking"
        mean_std_subset$Activity[mean_std_subset$Activity == "2"] <- "Walking Upstairs"
        mean_std_subset$Activity[mean_std_subset$Activity == "3"] <- "Walking Downstairs"
        mean_std_subset$Activity[mean_std_subset$Activity == "4"] <- "Sitting"
        mean_std_subset$Activity[mean_std_subset$Activity == "5"] <- "Standing"
        mean_std_subset$Activity[mean_std_subset$Activity == "6"] <- "Laying"

## 4) Labeling the data set with descriptive variable names (the same variable 
##      names used in the original data set, taken from 'features.txt') 

        setwd("/Users/Javier/Desktop/UCI HAR Dataset/")
        features_table <- read.table("features.txt", header = FALSE)
        features_vector_char <- as.character(features_table$V2)
        subset_features_vector <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,
                                    215,227,228,240,241,253,254,266:271,345:350,
                                    424:429,503,504,516,517,529,530,542,543)
        var_names <- features_vector_char[subset_features_vector]
        names(mean_std_subset) <- c("Subject","Activity",var_names)
        
## 5) Creating the tidy data set with the average of each variable for each 
##      activity and each subject.

        library(dplyr)
        sub_act_groups <- mean_std_subset %>% group_by(Subject, Activity)
        final_clean_tidy_super_beautiful_data_set <- sub_act_groups %>%  
                summarise_each(funs(mean))
        write.table(final_clean_tidy_super_beautiful_data_set, file = 
                "/Users/Javier/Desktop/UCI HAR Dataset/UCI_Har_Tidy_Data.txt", 
                row.names = FALSE)
        
## The final table can be imported back to R and viewed with:
##      > data <- read.table("file_path", header = TRUE)
##      > View(data)
