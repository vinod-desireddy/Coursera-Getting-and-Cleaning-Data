Coursera-Getting and Cleaning Data -week4 assignment

This repository is created to explain the steps of the week4 assignment of the course - Getting and Cleaning Data
1. Downloading the data from url, unzipped in to the R working directory
2. The objects loaded in to R are - 
	1.activity_labels.txt
	2.features.txt
	3.X_train.txt
	4.y_train.txt
	5.subject_train.txt
	6.X_test.txt
	7.y_test.txt
	8.subject_test.txt

3. feature names in the features.txt are changed appropriately so as to use them as column names of X_train.txt and y_train.txt

4. subject_train.txt and subject_test.txt, identify the subjects performed the activity window wise. 

5. subject_train and y_train are merged with X_train and subject_test and y_test are merged with subject_test and y_test are merged with X_test.

6. Now the datasets X_train and X_test are merged rowwise to create a dataset 'data'.

7. activity numbers in the data are given appropriate activity names by merging them with activity_labels.txt.

8. From 'data', only the features with measurements mean and standard deviation are extracted.

9. Average of the each variable for each activity and each subject is calculated and saved to the finalTidydata.