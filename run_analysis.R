## Script prepared 18/sept/2015 in fulfillment of the course project requirements
## Coursera Getting and Cleaning Data

## Comments regarding code functionality prefixed #
## Comments relating to tieing the code back to the project instructions prefixed ###
## and start in column 1.


run_analysis <- function() {
  
  library(dplyr)
  # home_dir is the directory that the downloaded zip file extracts into.
  
# IMPORTANT VVVVVVV
  # set this variable for your particular machine
  home_dir <- "C:/Users/tpickering/Desktop/coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"
# IMPORTANT ^^^^^^^
  
  setwd(home_dir)
  
  # we want descriptive names for the columns - get these from the features.txt file
  # I eventually want a data frame which has the descriptive column names across the top
  # and the subject identifiers as the first column, so I create a vector of column headings
  # with the first element as the string "subject"
  features_data <- read.table("features.txt")
  col_names <- list()
  col_head <- list()
  col_head <- "subject"
  col_tail <- features_data[,2]
  
  # loop down the table transposing to a list
  col_names <- append(col_names, toString(col_head))
  for (i in 1:length(col_tail)) {
    col_names <- append(col_names, toString(col_tail[i]))
  }
  col_names <- append(col_names, "activity")
  
  activity_labels <- read.table("activity_labels.txt")
  
  # go to the directory containing the test data and read in first the test data
  # then the subject identifiers and finally zip the two data sets together
  setwd("./test")
  test_data <- read.table("X_test.txt", check.names=FALSE)
  test_subjects_data <- read.table("subject_test.txt")
  test_activities <- read.table("y_test.txt")
  test_activity_measures <- cbind(test_data,test_activities)
  merged_subject_test_data <- cbind(test_subjects_data,test_activity_measures)

  # do the same as above for the train data  
  setwd(home_dir)
  setwd("./train")
  train_data <- read.table("X_train.txt", check.names=FALSE)
  train_subjects_data <- read.table("subject_train.txt")
  train_activities <- read.table("y_train.txt")
  train_activity_measures <- cbind(train_data,train_activities)
  merged_subject_train_data <- cbind(train_subjects_data,train_activity_measures)
  
  #print(ncol(merged_subject_test_data))
  
  setwd(home_dir)
  
### Problem Step 1  Merges the training and the test sets to create one data set. 

  # now concatinate the two data sets and change the column headings from the default numerics
  # to the descriptive names we loaded from features.txt
  
 
  consolidated_data <- rbind(merged_subject_test_data, merged_subject_train_data)
  colnames(consolidated_data) <- col_names
  
  # because we now have descriptive column names we can pattern match to pick out
  # those which have "mean" or "std" in them.
  
  # do a basic check to make sure we didn't lose a row 
  if(nrow(consolidated_data) != (nrow(test_data) + nrow(train_data))){
    print("error in data load")  
  }
  
  # make sure that the columns have all come in too
  if(((ncol(consolidated_data) - 2) != ncol(test_data)) || (ncol(test_data) != ncol(train_data)) ){
    print("error in data consolidation")  
  }
  
### Problem Step 3 -  Uses descriptive activity names to name the activities in the data set
### I chose to go "wide" rather than "narrow" on the data structure so steps 2 and 3 are
### interchangeable in order.
    
  #put nice descriptive labels on the activities
  for (i in 1:nrow(consolidated_data)) {
    data_activity_code <- consolidated_data[i, "activity"]
    
    for(j in 1:nrow(activity_labels)){
      
      activity_labels_code <- activity_labels[j,1]
      activity_labels_text <- toString(activity_labels[j,2])
      
      if(activity_labels_code == data_activity_code) {
        consolidated_data[i, "activity"] <-  activity_labels_text
      }
    }
  }
  
### Problem Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  # pick out those columns which refer to either a std or a mean - as per the spec
  # done by hand rather than iterating across the col names and using pattern matching
  # because there's not that many columns and it's just quicker
    
  # this is a selection operation. 
  tidy_frame <- consolidated_data [,c("subject", 
                                      "activity",
                                      "tBodyAcc-mean()-X",
                                      "tBodyAcc-mean()-Y",
                                      "tBodyAcc-mean()-Z",
                                      "tBodyAcc-std()-X",
                                      "tBodyAcc-std()-Y",
                                      "tBodyAcc-std()-Z",
                                      "tGravityAcc-mean()-X",
                                      "tGravityAcc-mean()-Y",
                                      "tGravityAcc-mean()-Z",
                                      "tGravityAcc-std()-X",
                                      "tGravityAcc-std()-Y",
                                      "tGravityAcc-std()-Z",
                                      "tBodyAccJerk-mean()-X",
                                      "tBodyAccJerk-mean()-Y",
                                      "tBodyAccJerk-mean()-Z",
                                      "tBodyAccJerk-std()-X",
                                      "tBodyAccJerk-std()-Y",
                                      "tBodyAccJerk-std()-Z",
                                      "tBodyGyro-mean()-X",
                                      "tBodyGyro-mean()-Y",
                                      "tBodyGyro-mean()-Z",
                                      "tBodyGyro-std()-X",
                                      "tBodyGyro-std()-Y",
                                      "tBodyGyro-std()-Z",
                                      "tBodyGyroJerk-mean()-X",
                                      "tBodyGyroJerk-mean()-Y",
                                      "tBodyGyroJerk-mean()-Z",
                                      "tBodyGyroJerk-std()-X",
                                      "tBodyGyroJerk-std()-Y",
                                      "tBodyGyroJerk-std()-Z",
                                      "tBodyAccMag-mean()",
                                      "tBodyAccMag-std()",
                                      "tGravityAccMag-mean()",
                                      "tGravityAccMag-std()",
                                      "tBodyAccJerkMag-mean()",
                                      "tBodyAccJerkMag-std()",
                                      "tBodyGyroMag-mean()",
                                      "tBodyGyroMag-std()",
                                      "tBodyGyroJerkMag-mean()",
                                      "tBodyGyroJerkMag-std()",
                                      "fBodyAcc-mean()-X",
                                      "fBodyAcc-mean()-Y",
                                      "fBodyAcc-mean()-Z",
                                      "fBodyAcc-std()-X",
                                      "fBodyAcc-std()-Y",
                                      "fBodyAcc-std()-Z",
                                      "fBodyAcc-meanFreq()-X",
                                      "fBodyAcc-meanFreq()-Y",
                                      "fBodyAcc-meanFreq()-Z",
                                      "fBodyAccJerk-mean()-X",
                                      "fBodyAccJerk-mean()-Y",
                                      "fBodyAccJerk-mean()-Z",
                                      "fBodyAccJerk-std()-X",
                                      "fBodyAccJerk-std()-Y",
                                      "fBodyAccJerk-std()-Z",
                                      "fBodyAccJerk-meanFreq()-X",
                                      "fBodyAccJerk-meanFreq()-Y",
                                      "fBodyAccJerk-meanFreq()-Z",
                                      "fBodyGyro-mean()-X",
                                      "fBodyGyro-mean()-Y",
                                      "fBodyGyro-mean()-Z",
                                      "fBodyGyro-std()-X",
                                      "fBodyGyro-std()-Y",
                                      "fBodyGyro-std()-Z",
                                      "fBodyGyro-meanFreq()-X",
                                      "fBodyGyro-meanFreq()-Y",
                                      "fBodyGyro-meanFreq()-Z",
                                      "fBodyAccMag-mean()",
                                      "fBodyAccMag-std()",
                                      "fBodyBodyAccJerkMag-mean()",
                                      "fBodyBodyAccJerkMag-std()",
                                      "fBodyBodyGyroMag-mean()",
                                      "fBodyBodyGyroMag-std()",
                                      "fBodyBodyGyroMag-meanFreq()",
                                      "fBodyBodyGyroJerkMag-mean()",
                                      "fBodyBodyGyroJerkMag-std()",
                                      "fBodyBodyGyroJerkMag-meanFreq()")]
  
### Problem Step 4 - Appropriately labels the data set with descriptive variable names. 
  # The column names contain () and - these characters are not permitted input values for 
  # the column headings processed by dplyr so rename them.
  
  # code looks same as above - it's not - this is renaming not selection 
  colnames(tidy_frame) <- c("subject", 
                            "activity",
                            "tBodyAccmeanX",
                            "tBodyAccmeanY",
                            "tBodyAccmeanZ",
                            "tBodyAccstdX",
                            "tBodyAccstdY",
                            "tBodyAccstdZ",
                            "tGravityAccmeanX",
                            "tGravityAccmeanY",
                            "tGravityAccmeanZ",
                            "tGravityAccstdX",
                            "tGravityAccstdY",
                            "tGravityAccstdZ",
                            "tBodyAccJerkmeanX",
                            "tBodyAccJerkmeanY",
                            "tBodyAccJerkmeanZ",
                            "tBodyAccJerkstdX",
                            "tBodyAccJerkstdY",
                            "tBodyAccJerkstdZ",
                            "tBodyGyromeanX",
                            "tBodyGyromeanY",
                            "tBodyGyromeanZ",
                            "tBodyGyrostdX",
                            "tBodyGyrostdY",
                            "tBodyGyrostdZ",
                            "tBodyGyroJerkmeanX",
                            "tBodyGyroJerkmeanY",
                            "tBodyGyroJerkmeanZ",
                            "tBodyGyroJerkstdX",
                            "tBodyGyroJerkstdY",
                            "tBodyGyroJerkstdZ",
                            "tBodyAccMagmean",
                            "tBodyAccMagstd",
                            "tGravityAccMagmean",
                            "tGravityAccMagstd",
                            "tBodyAccJerkMagmean",
                            "tBodyAccJerkMagstd",
                            "tBodyGyroMagmean",
                            "tBodyGyroMagstd",
                            "tBodyGyroJerkMagmean",
                            "tBodyGyroJerkMagstd",
                            "fBodyAccmeanX",
                            "fBodyAccmeanY",
                            "fBodyAccmeanZ",
                            "fBodyAccstdX",
                            "fBodyAccstdY",
                            "fBodyAccstdZ",
                            "fBodyAccmeanFreqX",
                            "fBodyAccmeanFreqY",
                            "fBodyAccmeanFreqZ",
                            "fBodyAccJerkmeanX",
                            "fBodyAccJerkmeanY",
                            "fBodyAccJerkmeanZ",
                            "fBodyAccJerkstdX",
                            "fBodyAccJerkstdY",
                            "fBodyAccJerkstdZ",
                            "fBodyAccJerkmeanFreqX",
                            "fBodyAccJerkmeanFreqY",
                            "fBodyAccJerkmeanFreqZ",
                            "fBodyGyromeanX",
                            "fBodyGyromeanY",
                            "fBodyGyromeanZ",
                            "fBodyGyrostdX",
                            "fBodyGyrostdY",
                            "fBodyGyrostdZ",
                            "fBodyGyromeanFreqX",
                            "fBodyGyromeanFreqY",
                            "fBodyGyromeanFreqZ",
                            "fBodyAccMagmean",
                            "fBodyAccMagstd",
                            "fBodyBodyAccJerkMagmean",
                            "fBodyBodyAccJerkMagstd",
                            "fBodyBodyGyroMagmean",
                            "fBodyBodyGyroMagstd",
                            "fBodyBodyGyroMagmeanFreq",
                            "fBodyBodyGyroJerkMagmean",
                            "fBodyBodyGyroJerkMagstd",
                            "fBodyBodyGyroJerkMagmeanFreq")
  
### Problem Step 5 - From the data set in step 4, creates a second, independent tidy data set 
### with the average of each variable for each activity and each subject.

  #write.table(tidy_frame, file = "outA.txt", sep ="|", row.names = FALSE)  - debug info
  # this is the dplyr step that gives us the data structure we can run 
  #summary operations on
  grouped <- group_by(tidy_frame, subject, activity )
  
  # calculate the averages using the dplyr summarise() function  
  output <- summarise(grouped, mean(tBodyAccmeanX, na.rm = TRUE),
                  mean(tBodyAccmeanY, na.rm = TRUE),
                  mean(tBodyAccmeanZ, na.rm = TRUE),
                  mean(tBodyAccstdX, na.rm = TRUE),
                  mean(tBodyAccstdY, na.rm = TRUE),
                  mean(tBodyAccstdZ, na.rm = TRUE),
                  mean(tGravityAccmeanX, na.rm = TRUE),
                  mean(tGravityAccmeanY, na.rm = TRUE),
                  mean(tGravityAccmeanZ, na.rm = TRUE),
                  mean(tGravityAccstdX, na.rm = TRUE),
                  mean(tGravityAccstdY, na.rm = TRUE),
                  mean(tGravityAccstdZ, na.rm = TRUE),
                  mean(tBodyAccJerkmeanX, na.rm = TRUE),
                  mean(tBodyAccJerkmeanY, na.rm = TRUE),
                  mean(tBodyAccJerkmeanZ, na.rm = TRUE),
                  mean(tBodyAccJerkstdX, na.rm = TRUE),
                  mean(tBodyAccJerkstdY, na.rm = TRUE),
                  mean(tBodyAccJerkstdZ, na.rm = TRUE),
                  mean(tBodyGyromeanX, na.rm = TRUE),
                  mean(tBodyGyromeanY, na.rm = TRUE),
                  mean(tBodyGyromeanZ, na.rm = TRUE),
                  mean(tBodyGyrostdX, na.rm = TRUE),
                  mean(tBodyGyrostdY, na.rm = TRUE),
                  mean(tBodyGyrostdZ, na.rm = TRUE),
                  mean(tBodyGyroJerkmeanX, na.rm = TRUE),
                  mean(tBodyGyroJerkmeanY, na.rm = TRUE),
                  mean(tBodyGyroJerkmeanZ, na.rm = TRUE),
                  mean(tBodyGyroJerkstdX, na.rm = TRUE),
                  mean(tBodyGyroJerkstdY, na.rm = TRUE),
                  mean(tBodyGyroJerkstdZ, na.rm = TRUE),
                  mean(tBodyAccMagmean, na.rm = TRUE),
                  mean(tBodyAccMagstd, na.rm = TRUE),
                  mean(tGravityAccMagmean, na.rm = TRUE),
                  mean(tGravityAccMagstd, na.rm = TRUE),
                  mean(tBodyAccJerkMagmean, na.rm = TRUE),
                  mean(tBodyAccJerkMagstd, na.rm = TRUE),
                  mean(tBodyGyroMagmean, na.rm = TRUE),
                  mean(tBodyGyroMagstd, na.rm = TRUE),
                  mean(tBodyGyroJerkMagmean, na.rm = TRUE),
                  mean(tBodyGyroJerkMagstd, na.rm = TRUE),
                  mean(fBodyAccmeanX, na.rm = TRUE),
                  mean(fBodyAccmeanY, na.rm = TRUE),
                  mean(fBodyAccmeanZ, na.rm = TRUE),
                  mean(fBodyAccstdX, na.rm = TRUE),
                  mean(fBodyAccstdY, na.rm = TRUE),
                  mean(fBodyAccstdZ, na.rm = TRUE),
                  mean(fBodyAccmeanFreqX, na.rm = TRUE),
                  mean(fBodyAccmeanFreqY, na.rm = TRUE),
                  mean(fBodyAccmeanFreqZ, na.rm = TRUE),
                  mean(fBodyAccJerkmeanX, na.rm = TRUE),
                  mean(fBodyAccJerkmeanY, na.rm = TRUE),
                  mean(fBodyAccJerkmeanZ, na.rm = TRUE),
                  mean(fBodyAccJerkstdX, na.rm = TRUE),
                  mean(fBodyAccJerkstdY, na.rm = TRUE),
                  mean(fBodyAccJerkstdZ, na.rm = TRUE),
                  mean(fBodyAccJerkmeanFreqX, na.rm = TRUE),
                  mean(fBodyAccJerkmeanFreqY, na.rm = TRUE),
                  mean(fBodyAccJerkmeanFreqZ, na.rm = TRUE),
                  mean(fBodyGyromeanX, na.rm = TRUE),
                  mean(fBodyGyromeanY, na.rm = TRUE),
                  mean(fBodyGyromeanZ, na.rm = TRUE),
                  mean(fBodyGyrostdX, na.rm = TRUE),
                  mean(fBodyGyrostdY, na.rm = TRUE),
                  mean(fBodyGyrostdZ, na.rm = TRUE),
                  mean(fBodyGyromeanFreqX, na.rm = TRUE),
                  mean(fBodyGyromeanFreqY, na.rm = TRUE),
                  mean(fBodyGyromeanFreqZ, na.rm = TRUE),
                  mean(fBodyAccMagmean, na.rm = TRUE),
                  mean(fBodyAccMagstd, na.rm = TRUE),
                  mean(fBodyBodyAccJerkMagmean, na.rm = TRUE),
                  mean(fBodyBodyAccJerkMagstd, na.rm = TRUE),
                  mean(fBodyBodyGyroMagmean, na.rm = TRUE),
                  mean(fBodyBodyGyroMagstd, na.rm = TRUE),
                  mean(fBodyBodyGyroMagmeanFreq, na.rm = TRUE),
                  mean(fBodyBodyGyroJerkMagmean, na.rm = TRUE),
                  mean(fBodyBodyGyroJerkMagstd, na.rm = TRUE),
                  mean(fBodyBodyGyroJerkMagmeanFreq, na.rm = TRUE) )

  # summarize() gives really ugly column headings by default - so substiture with
  # something a lot more readable
  colnames(output) <- c("subject", 
                            "activity",
                            "mean_tBodyAccMeanX",
                            "mean_tBodyAccMeanY",
                            "mean_tBodyAccMeanZ",
                            "mean_tBodyAccStdX",
                            "mean_tBodyAccStdY",
                            "mean_tBodyAccStdZ",
                            "mean_tGravityAccMeanX",
                            "mean_tGravityAccMeanY",
                            "mean_tGravityAccMeanZ",
                            "mean_tGravityAccStdX",
                            "mean_tGravityAccstdY",
                            "mean_tGravityAccstdZ",
                            "mean_tBodyAccJerkMeanX",
                            "mean_tBodyAccJerkMeanY",
                            "mean_tBodyAccJerkMeanZ",
                            "mean_tBodyAccJerkStdX",
                            "mean_tBodyAccJerkStdY",
                            "mean_tBodyAccJerkStdZ",
                            "mean_tBodyGyroMeanX",
                            "mean_tBodyGyroMeanY",
                            "mean_tBodyGyroMeanZ",
                            "mean_tBodyGyroStdX",
                            "mean_tBodyGyroStdY",
                            "mean_tBodyGyroStdZ",
                            "mean_tBodyGyroJerkMeanX",
                            "mean_tBodyGyroJerkMeanY",
                            "mean_tBodyGyroJerkMeanZ",
                            "mean_tBodyGyroJerkStdX",
                            "mean_tBodyGyroJerkStdY",
                            "mean_tBodyGyroJerkStdZ",
                            "mean_tBodyAccMagMean",
                            "mean_tBodyAccMagStd",
                            "mean_tGravityAccMagMean",
                            "mean_tGravityAccMagStd",
                            "mean_tBodyAccJerkMagMean",
                            "mean_tBodyAccJerkMagStd",
                            "mean_tBodyGyroMagMean",
                            "mean_tBodyGyroMagStd",
                            "mean_tBodyGyroJerkMagMean",
                            "mean_tBodyGyroJerkMagStd",
                            "mean_fBodyAccMeanX",
                            "mean_fBodyAccMeanY",
                            "mean_fBodyAccMeanZ",
                            "mean_fBodyAccStdX",
                            "mean_fBodyAccStdY",
                            "mean_fBodyAccStdZ",
                            "mean_fBodyAccMeanFreqX",
                            "mean_fBodyAccMeanFreqY",
                            "mean_fBodyAccMeanFreqZ",
                            "mean_fBodyAccJerkMeanX",
                            "mean_fBodyAccJerkMeanY",
                            "mean_fBodyAccJerkMeanZ",
                            "mean_fBodyAccJerkStdX",
                            "mean_fBodyAccJerkStdY",
                            "mean_fBodyAccJerkStdZ",
                            "mean_fBodyAccJerkMeanFreqX",
                            "mean_fBodyAccJerkMeanFreqY",
                            "mean_fBodyAccJerkMeanFreqZ",
                            "mean_fBodyGyroMeanX",
                            "mean_fBodyGyroMeanY",
                            "mean_fBodyGyroMeanZ",
                            "mean_fBodyGyroStdX",
                            "mean_fBodyGyroStdY",
                            "mean_fBodyGyroStdZ",
                            "mean_fBodyGyroMeanFreqX",
                            "mean_fBodyGyroSeanFreqY",
                            "mean_fBodyGyroMeanFreqZ",
                            "mean_fBodyAccMagMean",
                            "mean_fBodyAccMagStd",
                            "mean_fBodyBodyAccJerkMagMean",
                            "mean_fBodyBodyAccJerkMagStd",
                            "mean_fBodyBodyGyroMagMean",
                            "mean_fBodyBodyGyroMagStd",
                            "mean_mean_fBodyBodyGyroMagMeanFreq",
                            "mean_fBodyBodyGyroJerkMagMean",
                            "mean_fBodyBodyGyroJerkMagStd",
                            "mean_fBodyBodyGyroJerkMagMeanFreq")
  
  # band the results out to a file - I prefer explicit column separators so using a |
  # as being something which wont appear in the input.
  write.table(output, file = "out.txt", sep ="|", row.names = FALSE)
  
  #print(nrow(test_subjects_data))
  #print(nrow(test_activities))
  #print(nrow(consolidated_data))
  #print(ncol(consolidated_data))
  #print(tidy_frame)
  
}

run_analysis()

  
