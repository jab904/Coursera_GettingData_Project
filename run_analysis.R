## Set working directory
setwd("C:/Users/JEB/Desktop/Coursera")
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Download the files from the web and unzip them
download.file(fileUrl, dest=".\\data\\files.zip", mode="wb")
unzip(zipfile=".\\data\\files.zip", exdir=".\\data")

## Read the files
filelist=list.files("data/UCI HAR Dataset", full.names = T)
activity_labels<-read.table(filelist[1], header=F)
features<-read.table(filelist[2], header=F)

filelisttest=list.files("data/UCI HAR Dataset/test", full.names = T)
test_subject<-read.table(filelisttest[2], header=F)
test_data<-read.table(filelisttest[3], header=F)
test_activity<-read.table(filelisttest[4], header=F)

filelisttrain=list.files("data/UCI HAR Dataset/train", full.names = T)
train_subject<-read.table(filelisttrain[2], header=F)
train_data<-read.table(filelisttrain[3], header=F)
train_activity<-read.table(filelisttrain[4], header=F)

## Merge training and test data
merged_data<-rbind(train_data, test_data)
merged_subjects<-rbind(train_subject, test_subject)
names(merged_subjects)<-"Subject"
merged_activity<-rbind(train_activity, test_activity)
names(merged_activity)<-"Activity"

## Add column names
y<-as.vector(features$V2)
names(merged_data)<-y

## Extract only mean and standard deviation, and add subject and activity column
mean_std<-grep("\\mean()\\b|std()", names(merged_data))
merged_data<-merged_data[,mean_std]
merged_data<-cbind(merged_subjects, merged_activity, merged_data)

## Clean up column names
names(merged_data)<-gsub("\\(\\)","", names(merged_data))
names(merged_data)<-gsub("-","", names(merged_data))

## Add activity names
x<-as.vector(activity_labels$V1)
z<-as.vector(activity_labels$V2)

for (i in 1:length(x)) {
  merged_data$Activity<-gsub(x[i], z[i], merged_data$Activity)
}
library(dplyr)
q<-merged_data %>% arrange(Subject, Activity) %>% group_by(Subject, Activity) %>% summarize_each(funs(mean))
write.table(q, "tidyUCIdata.txt", row.names = F)