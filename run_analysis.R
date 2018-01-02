#########################################
#Jared P. Lee
#Date Created: 17 Dec 17
#Getting and Cleaning Data Course Project
#########################################


# load required packages
library(dplyr)
library(reshape2)

# download data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "Data.zip")

# read in features to use as human readable columns names
features <- read.table(unz("Data.zip", "UCI HAR Dataset/features.txt"), col.names = c("code", "feature"),
                       stringsAsFactors = FALSE)

# read in the activity labels
activity_labels <- read.table(unz("Data.zip", "UCI HAR Dataset/activity_labels.txt"), 
                       col.names = c("actcode", "actname"), stringsAsFactors = FALSE)


# capture column names for merged file
columnNames <- c(features$feature,"subjectcode","actname")

# read test files
test_set <- read.table(unz("Data.zip", "UCI HAR Dataset/test/X_test.txt"))
test_labels <- read.table(unz("Data.zip", "UCI HAR Dataset/test/y_test.txt"), sep = "\n", header = F)
test_subject <- read.table(unz("Data.zip", "UCI HAR Dataset/test/subject_test.txt"))

# read train files
train_set <- read.table(unz("Data.zip", "UCI HAR Dataset/train/X_train.txt"))
train_labels <- read.table(unz("Data.zip", "UCI HAR Dataset/train/y_train.txt"), sep = "\n", header = F)
train_subject <- read.table(unz("Data.zip", "UCI HAR Dataset/train/subject_train.txt"))

# bind all dataframes and create vectors for all_labels and all_subject
all_set <- rbind(test_set, train_set)
all_labels <- rbind(test_labels, train_labels)
all_subject <- rbind(test_subject, train_subject)

# merge subject data
all_set$all_subject <- all_subject$V1

# relabel activities with names
colnames(all_labels) <- "actcode"
all_labels <- join(all_labels, activity_labels, by = "actcode", type = "left")
all_labels$actcode <- NULL

# merge activity indicator with df
all_set$all_labels <- all_labels$actname

# rename all columns
colnames(all_set) <- columnNames

# rename to all
all <- all_set

# create a character vector of only mean and std measures
meanstdlogical <- grepl(x = features$feature, pattern = "std|mean")
features <- features$feature
meanstdname <- as.character(features[meanstdlogical])

# keep only mean and std data
all <- all[, meanstdlogical]

# reshape and keep only the means
# allmelt <- melt(all, id=c("subjectcode", "actname"), measure.vars=meanstdname)
# alltidy <- dcast(data = allmelt, subjectcode + actname ~ variable, mean)

tidy_data <- melt(all, id=c("subjectcode", "actname"), measure.vars=meanstdname) %>%
              dcast(data = allmelt, subjectcode + actname ~ variable, mean)

# output file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
