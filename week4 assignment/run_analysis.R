#Coursera - Getting and Cleaning Data - week4 - assignment
#url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
#download.file(url, 'data.zip', 'curl')
#rm(url)

#loading the 6 types of activity (key-value) labels data
activity_labels <- read.table("activity_labels.txt",
                              col.names = c('activitynumber', 'activityname'), 
                              colClasses = rep('factor', 2))
str(activity_labels)

#loading the names of columns of training set data
features <- read.table("features.txt",
                       col.names = c('rownumber', 'featurename'), 
                       colClasses = c('integer', 'character'))
str(features)

#replacing '-' with '_' in the feature names so that it can be used as a column name
features$featurename <- gsub('\\-', '_', features$featurename)
#replacing the '()' paranthesis with 'P' so that it will be easy to identify
features$featurename <- gsub('\\(\\)', 'P', features$featurename)

#loading training set data with features as column names
train_data <- read.table("train/X_train.txt",
                         col.names = features$featurename,
                         colClasses = rep('numeric', length(features$featurename)))
str(train_data)
#checking for NA values
which(colSums(is.na(train_data)) > 0)

#reading the activity data of the each observation of the training data
train_labels <- read.table("train/y_train.txt", 
                           col.names = 'activitynumber', colClasses = 'factor')
str(train_labels)

#merging the activity data of the training data with activity lables for 
#     aquiring the name of the activity of the training set
train_labels <- merge(activity_labels, train_labels, 
                      by.x = 'activitynumber', 
                      by.y = 'activitynumber', 
                      all.y = T)

#loading the subject data to identify the subject who performed the activity
train_subject <- read.table("train/subject_train.txt",
                            col.names = 'subjectnumber', colClasses = 'factor')
str(train_subject)

#combining the acivity and subject details with training data
train_data = cbind(train_subject, train_labels, train_data)

#removing the objects that are not required
rm(train_labels)
rm(train_subject)


#loading test set data with features as column names
test_data <- read.table("test//X_test.txt",
                        col.names = features$featurename, 
                        colClasses = rep('numeric', length(features$featurename)))
str(test_data)
#checking for NA values
which(colSums(is.na(test_data)) > 0)

#reading the activity data of the each observation of the test data
test_labels <- read.table("test//y_test.txt", 
                          col.names = 'activitynumber', colClasses = 'factor')
str(test_labels)

#merging the activity data of the test data with activity lables for 
#     aquiring the name of the activity of the test set
test_labels <- merge(activity_labels, test_labels, 
                     by.x = 'activitynumber', 
                     by.y = 'activitynumber', 
                     all.y = T)

#loading the subject data to identify the subject who performed the activity
test_subject <- read.table("test/subject_test.txt",
                            col.names = 'subjectnumber', colClasses = 'factor')
str(test_subject)

#combining the acivity and subject details with test data
test_data = cbind(test_subject, test_labels, test_data)

#removing the objects that are not required
rm(test_labels)
rm(test_subject)

rm(features)
rm(activity_labels)

#combining the Training and Test data to make one complete dataset
data = rbind(train_data,test_data)

#removing the objects that are not required
rm(train_data)
rm(test_data)

#Extracting only the features with measurements mean and standard deviation
required_data = data[,c(1,3, grep('_meanp|_stdp', tolower(names(data))))]

#Appropriately labelling the data set with descriptive variable names.
features = colnames(required_data)
features = sub('Acc', 'Acceleration', features)
features = sub('Gyro', 'Gyroscope', features)
features = sub('Mag', 'Magnitude', features)
features = sub('meanP', 'mean', features)
features = sub('stdP', 'stddev', features)

#renaming the dataset with appropriate names
names(required_data) = features

#removing the objects that are not required
rm(features)

#creating a tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
finalTidydata <- required_data %>% group_by(activityname, subjectnumber) %>% summarise_all(mean, na.rm = T)

#removing the objects that are not required
rm(data)
rm(required_data)

#writing the final tidy dataset to the directory
write.csv(finalTidydata, 'finalTidydata.csv', row.names = F)

#removing the objects that are not required
#rm(finalTidydata)