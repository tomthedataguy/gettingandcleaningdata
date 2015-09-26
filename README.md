# README for the Getting and Cleaning Data course project
Prepared 21/Sept/2015 - Tom Pickering

### R prequisites
The program assumes that you have the following R libraries installed in your
environment:

library(dplyr)

### Download files
Download the zip file from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip it using an appropriate tool on your system. This will give you the tree
and file structure shown in the CodeBook.md file.

### Setting the home and working directories
The code contains the following line:

  home_dir <- "C:/Users/tpickering/Desktop/coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"

This is the location for where the data set was downloaded on the machine on
this code was developed. You must edit this variable to reflect the directory
structure of the machine you run the code on.

The code manages the moves around the tree structure set up by unzipping this
do not move all of the files into one directory. Leave the unzipped structure
as it is.

### Output / results
The results from running the file are output to the file tidy_data.txt which
will be located in the directory specified as  home_dir above.

### Transforms on the data
The downloaded data comes in the as two halves Test and Train.
These two data sets have to be separately enriched and then concatenated -
joined end on end - to give one consolidated data set.

The specific files used are set out in the file CodeBook.md.

The basic outline of the processing is:
* Read the test or train data into a data frame.
* Add on appropriate column headings by renaming the data frame column headings
  with the data from features.txt
* Add the activity labels - one for each row - from the activity files. Do this
  by adding to the left of the data frame one by one. Each row in the two sets
  corresponds by row number. ie the 4th row in one file relates to the 4th row
  in the second file.
* Add the subject identifiers to the data set.  Do this by adding to the left   
  of the data frame one by one. Each row in the two sets corresponds by row
  number. ie the 4th row in one file relates to the 4th row in the second file.

This gives 2 data frames which contain all of the information needed to perform
the data processing.

Join these two dataframes end to end to give one much larger (longer) data frame
which can be used for the consolidated processing.

The data was processed at the end of the concatenation since the input files
did not specify that either the test or train data contained only unique
subjects or activities.

The dplyr package was used to derive mean values for the data set.

Since the column headings are not machine readable (or particularly human
friendly) a set of more appropriate column headings were substituted. Since
little information was given as to the real semantic meaning of the columns
in the readme.txt file supplied in the zip file a simplistic naming convention
was chosen. This was felt to be clearer and less error prone than guessing.

A brief synopsis of the processing don on each file follows. For the contents
of the file see the file CodeBook.md.

1. subject_test.txt
    A list of subject identifiers from drawn from a set of 1 - 30.
    Each row in the file corresponds by position with one of the rows in
    X_test. This file was joined to X_test as the left most column.

2.  X_test.txt
    A matrix of data arranged in columns and rows. This file formed the basis
    for one of two main data frames used during the processing (other data
    was used to enrich this data frame).  It was later concatenated with
    X_train for production of mean data on the data set.

3.  y_test.txt
    A list of activity labels from 1 to 6. These labels were joined to the
    X_test data frame to give human friendly descriptions of the activities
    in each subject / activity pairing which forms the basis for the rows in the
    tidy_data.

4.  subject_train.txt
    See subject_test.txt - but for the X_train data set.

5.  X_train.txt
    Along with X_test this forms the basic data for the exercise. It is a matrix
    of data arranged in columns and rows. Each intersection (analogous to a cell
    in a spreadsheet) contains one reading.

6.  y_train.txt
    A list of activity labels from 1 to 6. Each row corresponds with one of
    the rows in X_train.txt. This file is joined to the left of X_train.txt
    to give an additional column. Similar to y_test.txt above.

7.  activity_labels.txt
    Gives the test equivalents for the activity numbers in X_train.txt and
    X_test.txt. Each of the files are keyed 1 - 6. Use the commonality of keys
    to join the two files together.

8.  features.txt
    This file forms the column headings in the data table being produced. There
    is a one for one correspondence between the rows in the features.txt file
    and the columns of X_train.txt and X_test.txt. The names are changed once
    during the production of the concatenated data frame and once again
    before outputting the data as tidy_data.txt

9. tidy_data.txt
   The final consolidated data frame is output to this file.


### Description of experiment and data files
Are all contained in the file CodeBook.md
