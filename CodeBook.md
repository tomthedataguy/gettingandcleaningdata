# Code Book for the Getting and Cleaning Data course project
Prepared 21/Sept/2015 - Tom Pickering

## Contents
* Summary of exercise
* Input Files
* Output
* Other files
* README.md

## Summary of exercise
A number of files were supplied in a .zip file containing data obtained
from the intertial sensors from a Samsung Mobile Phone while 30 experimental
test subjects carried out one of 6 specific activities.

The data was divided into two distinct parts. a Train set and Test set. The
data structure of the two sets was identical, however the data varied between
sets.

The data itself was split into 8 files, each of which represented a distinct
subset of the data. None of the data files contained overlapping data.

The objective of the exercise was to produce a tidy data set (coulmns and rows
with the each column row intersection containing only exactly one data item)
labeled appropriately and with each data item representing the mean of the
sensor activity named by the label for each specific subject / activity
pairing.

## Input Files
The following files are used in the preparation of the results data set:

1.  getdata-projectfiles-UCI HAR Dataset.zip
    the source file for all of the input data.

    Downloaded from:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

When this file is unzipped it will give a number of files in a small directory
tree. The files below with "train" in their name are located in the "train"
directory, those with "test" in the name are in the "test" directory
the remaining files are in the root of the "UCI HAR Dateset directory".

UCI HAR Dataset \ |
                  |-- test\
                  |
                  |-- train\
                  |
                  | some files

2.  subject_test.txt
    A list of subject identifiers from drawn from a set of 1 - 30.
    Each line item in the file represents a single individual performing a
    single action. There is a row for each row in the file X_test. It is
    possible to use the data in this file as a column in the consolidated set
    for those rows which come from X_test.

3.  X_test.txt
    A matrix of data arranged in columns and rows representing the readings
    from a number of sensors in a Samsung mobile phone taken as a specific
    test subject performed 1 of six different activities. Each row represents
    a distinct subject / activity pairing. eg. row 14 may represent subject
    4 performing activity 2. row 378 may be subject 25 performing activity 4.

4.  y_test.txt
    A list of activity labels from 1 to 6. The labels each correspond to one
    row in the file X_test.txt. It is possible to use the data in this file
    as a column in the consolidated set for those rows which come from X_test.

5.  subject_train.txt
    A list of subject identifiers from drawn from a set of 1 - 30.
    Each line item in the file represents a single individual performing a
    single action. There is a row for each row in the file X_test. It is
    possible to use the data in this file as a column in the consolidated set
    for those rows which come from X_test.

6.  X_train.txt
    A matrix of data arranged in columns and rows representing the readings
    from a number of sensors in a Samsung mobile phone taken as a specific
    test subject performed 1 of six different activities. Each row represents
    a distinct subject / activity pairing. eg. row 14 may represent subject
    4 performing activity 2. row 378 may be subject 25 performing activity 4.

7.  y_train.txt
    A list of activity labels from 1 to 6. The labels each correspond to one
    row in the file X_test.txt. It is possible to use the data in this file
    as a column in the consolidated set for those rows which come from X_test.

8.  activity_labels.txt
    A list of the 6 different activities which were undertaken by the subjects
    cross referenced by activity numbers 1 - 6

   * 1 WALKING
   * 2 WALKING_UPSTAIRS
   * 3 WALKING_DOWNSTAIRS
   * 4 SITTING
   * 5 STANDING
   * 6 LAYING

9.  features.txt
    A list of the metrics captured and measured by the onboard sensor for the
    phone used in this set of experiments. The file is arranged as a list of
    rows. Each row is the name of a specific measure. It is possible to

10. output.txt - pipe separated "|" tidy data set containing the output from the
    exercise.

## Output
The result of running the scrip is a file tidy_data.txt.

The file has the following format:

subject | activity | list of measurements separated by pipe -> "|"

The column names in the output file are modifications from those in the
features.txt file in that they omit  "-" "(" and ")" and are prefixed with
"mean_" to indicate that they are calculated values showing a mean of the
raw data in the input files.

The following table shows the correspondences.

    Column names as supplied          Column names used in the
    in features.txt                   tidy data output file.
    ========================          ========================
    "subject",                        "subject",
    "activity",                       "activity",
    "tBodyAcc-mean()-X",              "mean_tBodyAccMeanX",
    "tBodyAcc-mean()-Y",              "mean_tBodyAccMeanY",
    "tBodyAcc-mean()-Z",              "mean_tBodyAccMeanZ",
    "tBodyAcc-std()-X",               "mean_tBodyAccStdX",
    "tBodyAcc-std()-Y",               "mean_tBodyAccStdY",
    "tBodyAcc-std()-Z",               "mean_tBodyAccStdZ",
    "tGravityAcc-mean()-X",           "mean_tGravityAccMeanX",
    "tGravityAcc-mean()-Y",           "mean_tGravityAccMeanY",
    "tGravityAcc-mean()-Z",           "mean_tGravityAccMeanZ",
    "tGravityAcc-std()-X",            "mean_tGravityAccStdX",
    "tGravityAcc-std()-Y",            "mean_tGravityAccstdY",
    "tGravityAcc-std()-Z",            "mean_tGravityAccstdZ",
    "tBodyAccJerk-mean()-X",          "mean_tBodyAccJerkMeanX",
    "tBodyAccJerk-mean()-Y",          "mean_tBodyAccJerkMeanY",
    "tBodyAccJerk-mean()-Z",          "mean_tBodyAccJerkMeanZ",
    "tBodyAccJerk-std()-X",           "mean_tBodyAccJerkStdX",
    "tBodyAccJerk-std()-Y",           "mean_tBodyAccJerkStdY",
    "tBodyAccJerk-std()-Z",           "mean_tBodyAccJerkStdZ",
    "tBodyGyro-mean()-X",             "mean_tBodyGyroMeanX",
    "tBodyGyro-mean()-Y",             "mean_tBodyGyroMeanY",
    "tBodyGyro-mean()-Z",             "mean_tBodyGyroMeanZ",
    "tBodyGyro-std()-X",              "mean_tBodyGyroStdX",
    "tBodyGyro-std()-Y",              "mean_tBodyGyroStdY",
    "tBodyGyro-std()-Z",              "mean_tBodyGyroStdZ",
    "tBodyGyroJerk-mean()-X",         "mean_tBodyGyroJerkMeanX",
    "tBodyGyroJerk-mean()-Y",         "mean_tBodyGyroJerkMeanY",
    "tBodyGyroJerk-mean()-Z",         "mean_tBodyGyroJerkMeanZ",
    "tBodyGyroJerk-std()-X",          "mean_tBodyGyroJerkStdX",
    "tBodyGyroJerk-std()-Y",          "mean_tBodyGyroJerkStdY",
    "tBodyGyroJerk-std()-Z",          "mean_tBodyGyroJerkStdZ",
    "tBodyAccMag-mean()",             "mean_tBodyAccMagMean",
    "tBodyAccMag-std()",              "mean_tBodyAccMagStd",
    "tGravityAccMag-mean()",          "mean_tGravityAccMagMean",
    "tGravityAccMag-std()",           "mean_tGravityAccMagStd",
    "tBodyAccJerkMag-mean()",         "mean_tBodyAccJerkMagMean",
    "tBodyAccJerkMag-std()",          "mean_tBodyAccJerkMagStd",
    "tBodyGyroMag-mean()",            "mean_tBodyGyroMagMean",
    "tBodyGyroMag-std()",             "mean_tBodyGyroMagStd",
    "tBodyGyroJerkMag-mean()",        "mean_tBodyGyroJerkMagMean",
    "tBodyGyroJerkMag-std()",         "mean_tBodyGyroJerkMagStd",
    "fBodyAcc-mean()-X",              "mean_fBodyAccMeanX",
    "fBodyAcc-mean()-Y",              "mean_fBodyAccMeanY",
    "fBodyAcc-mean()-Z",              "mean_fBodyAccMeanZ",
    "fBodyAcc-std()-X",               "mean_fBodyAccStdX",
    "fBodyAcc-std()-Y",               "mean_fBodyAccStdY",
    "fBodyAcc-std()-Z",               "mean_fBodyAccStdZ",
    "fBodyAcc-meanFreq()-X",          "mean_fBodyAccMeanFreqX",
    "fBodyAcc-meanFreq()-Y",          "mean_fBodyAccMeanFreqY",
    "fBodyAcc-meanFreq()-Z",          "mean_fBodyAccMeanFreqZ",
    "fBodyAccJerk-mean()-X",          "mean_fBodyAccJerkMeanX",
    "fBodyAccJerk-mean()-Y",          "mean_fBodyAccJerkMeanY",
    "fBodyAccJerk-mean()-Z",          "mean_fBodyAccJerkMeanZ",
    "fBodyAccJerk-std()-X",           "mean_fBodyAccJerkStdX",
    "fBodyAccJerk-std()-Y",           "mean_fBodyAccJerkStdY",
    "fBodyAccJerk-std()-Z",           "mean_fBodyAccJerkStdZ",
    "fBodyAccJerk-meanFreq()-X",      "mean_fBodyAccJerkMeanFreqX",
    "fBodyAccJerk-meanFreq()-Y",      "mean_fBodyAccJerkMeanFreqY",
    "fBodyAccJerk-meanFreq()-Z",      "mean_fBodyAccJerkMeanFreqZ",
    "fBodyGyro-mean()-X",             "mean_fBodyGyroMeanX",
    "fBodyGyro-mean()-Y",             "mean_fBodyGyroMeanY",
    "fBodyGyro-mean()-Z",             "mean_fBodyGyroMeanZ",
    "fBodyGyro-std()-X",              "mean_fBodyGyroStdX",
    "fBodyGyro-std()-Y",              "mean_fBodyGyroStdY",
    "fBodyGyro-std()-Z",              "mean_fBodyGyroStdZ",
    "fBodyGyro-meanFreq()-X",         "mean_fBodyGyroMeanFreqX",
    "fBodyGyro-meanFreq()-Y",         "mean_fBodyGyroSeanFreqY",
    "fBodyGyro-meanFreq()-Z",         "mean_fBodyGyroMeanFreqZ",
    "fBodyAccMag-mean()",             "mean_fBodyAccMagMean",
    "fBodyAccMag-std()",              "mean_fBodyAccMagStd",
    "fBodyBodyAccJerkMag-mean()",     "mean_fBodyBodyAccJerkMagMean",
    "fBodyBodyAccJerkMag-std()",      "mean_fBodyBodyAccJerkMagStd",
    "fBodyBodyGyroMag-mean()",        "mean_fBodyBodyGyroMagMean",
    "fBodyBodyGyroMag-std()",         "mean_fBodyBodyGyroMagStd",
    "fBodyBodyGyroMag-meanFreq()",    "mean_mean_fBodyBodyGyroMagMeanFreq",
    "fBodyBodyGyroJerkMag-mean()",    "mean_fBodyBodyGyroJerkMagMean",
    "fBodyBodyGyroJerkMag-std()",     "mean_fBodyBodyGyroJerkMagStd",
    "fBodyBodyGyroJerkMag-meanFreq()" "mean_fBodyBodyGyroJerkMagMeanFreq"

The file is in "wide" format with one column for each of the headings above
representing exactly one metric and one row for each subject / activity
pairing, representing exactly one combination of values. Neither rows nor
columns are repeated.

## Other Files
Other files will be produced on unzipping the archive. These may safely be
disregarded for the purpose of this exercise.

## README.md
Please consult the README.md file for a description of the processing done to
each file.
