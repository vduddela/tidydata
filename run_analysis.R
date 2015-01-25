## step1 and step4

subject_train <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

X_train <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")

y_train <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

X_test <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")

y_test <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")

features <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")

listofnames <- as.character(features[,2])

listofnames <- make.names(listofnames, unique=TRUE)

listofnames <- gsub("...", ".", listofnames, fixed=TRUE)

listofnames <- gsub("..", ".", listofnames, fixed=TRUE)

listofnames <- gsub("BodyBody", "Body", listofnames, fixed=TRUE)

train <- cbind(subject_train, y_train, X_train)

test <- cbind(subject_test, y_test, X_test)

data <- rbind(train, test)

colnames(data) <- c("Subject_Id", "Activity", listofnames)

library(plyr)

data <- arrange(data,Subject_Id, Activity)


## step2

library(dplyr)

meandata <-select(data, contains("mean"))

stddata <- select(data, contains("std"))

subsetdata<-cbind(data$Subject_Id, data$Activity, meandata, stddata) 

colnames(subsetdata)[1] <- "Subject_Id"

colnames(subsetdata)[2] <- "Activity"


# step3

activity_label <-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

subsetdata[,2] <- activity_label[subsetdata[,2],2]


# step4
## Please see the explanation in step1


# step5 (use dplyr package for group_by and summarise_each)

tidydata <- summarise_each(group_by(subsetdata, Subject_Id, Activity), funs(mean))


write.table(tidydata, "./tidydata.txt",row.name=FALSE)

  

