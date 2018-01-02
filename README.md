# getcleandata_course_project
getcleandata_course_project

JPL - Getting and Cleaning Data Capstone Project
Uses Human Activity Recognition Using Smartphones Dataset
02 Jan 18

https://github.com/jaredplee/getcleandata_course_project

Below is information about a project completed as part of a specialization in data sciences. Information regarding this project can be found at coursera.org. The purpose of the project is to display proficiency in data cleaning and analysis. This document provides a summary of actions taken with respect to the original data set to create a single tidy data set according to the course instructions.

The original dataset contained information on an experiment using 30 volunteers within an age bracket of 19-48 years. Each volunteer performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a Samsung smartphone on the waist. An embedded accelerometer and gyroscope captured movement information in consistent intervals. The published dataset includes training and test data with pre-processed noise filters applied to summary statistics for each directional movement. Additional datasets include lists of activities and the identifier for each volunteer.

Data for this project can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Records include information on:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Files included with the original dataset:
- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

A description of measures to clean and tidy the data:
The link above contains a zip file. After placing this file in the working directory, the script (run_analysis.R) will load data on the 561 features and 6 activities included in the dataset. Then, we read files on test and training data for the subjects, the time and frequency domain measurements, and the activity codes that match the recorded information. Because all training and test sets are separate, the next step will combine them into a single dataframe for subjects, measurements, and activities. The three separate dataframes are then merged into a single data set containing 10,299 observations for 561 variables and identifiers for subjects and activities.

To make the information more digestible for the user, the headers are given easily identifiable names and the activity codes are replaced with strings denoting the actual activity. The remaining columns are filtered against a vector containing only required measurements for means and standard deviation for each feature. Finally, the dataset is reshaped to provide mean measurements for each required variable and for each subject and activity.

The resulting dataset, tidy_data.txt, contains 79 averages for each of the 6 activities and 30 subjects, or 180 records.
