## Steps to get tidy data set

The files for this assignment can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Note that not all of the files will be used to generate the tidy data set.
Once you set your working directory you can run the run_analysis.R script to generate the tidy data set.

### Steps in the R code to generate the tidy data set

* Set your working directory
* Downloaded files 
* Read relevant files and stored them in R objects
* Merged the training and test files using rbind, for the data the subjects and the activities
* Used the feature.txt file to name the columns in the merged data set
* Using grep, searched for columns that are a mean() or std()
* Subset the data to only contain the columns with mean or standard deviation
* Cleaned up column names, removed () and -
* Added the subjects and activity columns to the dataframe
* Using activity_labels.txt file, renamed the activities in the dataframe
* Created a new column (Subject.activity) that combines the subject and the activity
* Removed the subject column and activity column (since they were combined into one column in the previous step)
* Created a new tidy data set using the Subject.activity column which contains the average of each variable for each activity and each subject