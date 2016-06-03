#Loading the required libraries
library(dplyr)
library(plyr)
library(data.table)
library(tidyr)

#Reading the Subject Data from test and train
filepath<-"C:/Users/user/Desktop/FinalProject/UCI HAR Dataset"
subjecttest<-tbl_df(read.table(paste0(filepath,"/test/subject_test.txt")))
subjecttrain<-tbl_df(read.table(paste0(filepath,"/train/subject_train.txt")))


#Reading the Activity Data from test and train
filepath<-"C:/Users/user/Desktop/FinalProject/UCI HAR Dataset"
activitytest<-tbl_df(read.table(paste0(filepath,"/test/y_test.txt")))
activitytrain<-tbl_df(read.table(paste0(filepath,"/train/y_train.txt")))

#Reading the Data files from test and train
filepath<-"C:/Users/user/Desktop/FinalProject/UCI HAR Dataset"
datatest<-tbl_df(read.table(paste0(filepath,"/test/X_test.txt")))
datatrain<-tbl_df(read.table(paste0(filepath,"/train/X_train.txt")))

#Merging the subject data
allsubject<-rbind(subjecttest,subjecttrain)
names(allsubject)="SubjectNo"

#Merging the activity data
allactivity<-rbind(activitytest,activitytrain)
names(allactivity)="Activity"

#reading in the names of features
featurenames<-tbl_df(read.table(paste0(filepath,"/features.txt")))
names(featurenames)=c("Number","FeatureName")

#Merging the main data
alldata<-rbind(datatest, datatrain)
View(alldata)
names(alldata)<-featurenames$FeatureName

#Combining all data into one set
finaldata<-cbind(allsubject, allactivity, alldata)
View(finaldata)

#Feature names that contain mean and sd
onlymeansd<-grep("mean|std",featurenames$FeatureName)
meanstd<-featurenames[onlymeansd,2]
meanstd

#Data of only means and standard deviation
datasep<-finaldata[,as.character(meanstd$FeatureName)]
datasep<-cbind(SubjectNo=finaldata$SubjectNo, Activity=finaldata$Activity, datasep)

#Reading activity labels
activitylabels<-tbl_df(read.table("activity_labels.txt"))
View(activitylabels)

#Replace activity numbers with descriptive labels
finaldata$Activity<-as.factor(finaldata$Activity)

finaldata$Activity<-mapvalues(finaldata$Activity, from = c("1","2","3","4","5","6"), 
                              to = as.character(activitylabels$V2))
View(finaldata)
str(finaldata)


#Labelling the dataset with descriptive variable names
names(finaldata)<-gsub("std()", "Std Deviation", names(finaldata))
names(finaldata)<-gsub("mean()", "Mean", names(finaldata))
names(finaldata)<-gsub("^t", "Time", names(finaldata))
names(finaldata)<-gsub("^f", "Frequency", names(finaldata))
names(finaldata)<-gsub("Acc", "Accelerometer", names(finaldata))
names(finaldata)<-gsub("Gyro", "Gyroscope", names(finaldata))
names(finaldata)<-gsub("Mag", "Magnitude", names(finaldata))
names(finaldata)<-gsub("BodyBody", "Body", names(finaldata))

#New dataset, average of measurement for each Activity and each Subject
finaldata<-data.table(finaldata)
tidydata <- finaldata[, lapply(.SD, mean), by = 'SubjectNo,Activity']
View(tidydata)
write.table(tidydata, file = "tidy.txt", row.names = FALSE)
