# tidydata

# This README document explains how the script works for Course Project. The output will be written as tidydata.txt

# Step1 - Merge the training and the test sets to create one data set.

* The data for the project was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzipped all the files from it into the working directory.

# Reading of files
* The file subject_train was read into a dataframe subject_train in R using read.table command from train folder. 2 Other files in train folder X_train and y_train were read into variables X_train and y_train correspondingly. X_train contains Subject Id values and y_train contains Activity values. 

* similarly, 3 files in test folder(subject_test, X_test, y_test) were read into 3 dataframes(subject_test, X_test, y_test) respectively.X_test contains Subject Id values and y_test contains Activity values.

* Also read features.txt file from main folder "UCI HAR Dataset" into features dataframe in R.

# Please note that iam cleaning up the variables names in features from step1 now rather than in step 4 to prevent R from failing while reading the unformatted column names(column names having unacceptable R column formats like "-", "(", ")", ",", "...", "..")

* Extract the 2nd column values(as character) from the features variable to use the "values" as "columns" for the 'data' dataframe. It was assigned to listofnames list in R  
* change the values to columns using make.names command. parameter unique=TRUE eliminates the unwanted column formats like "-", "(", ")", and "," from column names and makes them unique.
* On close observation of the column names, it had "...", "..", and "%BodyBody%" in the column names. To make the column names look clean, these were eliminated using the command gsub("..." was changed to ".", ".." was changed to ".", %BodyBody% was changed to %Body%)

* All the 3 files extracted from train folder were merged on the columns using cbind since they all have the same number of rows. It was assigned to train dataframe in R
* All the 3 files extracted from test folder were merged on the columns using cbind since they all have the same number of rows. It was assigned to test dataframe in R
* The train and test dataframes were merged on the rows using rbind since they all have the same number of columns. It was assigned to data dataframe in R
* Column names were added to data dataframe using the colnames function(the Subject_Id, Activity and column names from list listofnames were matched to the data)
* sort the dataframe data on the Subject_Id and Activity columns using arrange function from plyr R package. This completes the merging of training and test sets to create one data set.

# Step2 - Extract only the measurements on the mean and standard deviation for each measurement. 

* Since the requirement is to extract only the mean and standard deviation of each measurement, all the data columns that had the words mean and standard deviation were extracted for this step. The assumption here is the mean and standard deviation is not restricted ONLY to time domain values, Fourier transform values or Angular values. Since the request was for each measurement, all the data columns with words mean and standard deviation were included. Also, meanfrequency columns are included since it represents the weighted mean values. 
  
* All the data column values with the word "mean" in their column names from the dataframe data were extracted using select function from dplyr R package. It was assigned to dataframe meandata.
* All the data column values with the word "std" in their column names from the dataframe data were extracted using select function from dplyr R package. It was assigned to dataframe stddata.
* The dataframe subsetdata was created by merging the Subject_Id, Activity, meandata and stddata from the dataframe data using cbind.

* Please note the first and second column names in the dataframe subsetdata will be named as data$Subject_id and data$Activity. It is renamed as Subject_Id and Activity respectively to avoid confusion while referencing them in dataframes data and subsetdata. This completes the step2 of assignment

# Step3 - Uses descriptive activity names to name the activities in the data set

* The file activity_labels.txt from main folder "UCI HAR Dataset" was read into dataframe activity_label in R. It contains 2 columns, first column with values like 1,2,...6 and second column with activities values like WALKING, WALKING_UPSTAIRS,...LAYING. 
* The first column values in dataframe activity_label was matched(by indexing) with the second column values in the dataframe subsetdata and replaced with the corresponding values in the second column of dataframe activity_label to second column values in the dataframe subsetdata.In other words, dataframe[,2] on the right hand side just returns the contents of the activity code (say="6"). This then is used as the index into activity_label_frame[6,2] which returns the label "laying". This then is assigned into the data frame on the left hand side. Since the row numbers are not supplied the operation, it is implicitly applied to all the rows in the dataframe.This completes the step3 of assignment.

# Step4 - Appropriately labels the data set with descriptive variable names

* Please see the explaination in step1 regarding the cleaning of the column names.

# Step5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* create a tidydata dataset by first group_by on Subject_Id and Activity of subsetdata and then summarize_each of the column values on the group_by for mean function. 
* write the tidydata dataset into working directory file as tidydata.txt using write.table with parameter row.name=FALSE. This completes the step5 of the assignment.
 


 