# DataCleaning_Project
# Project Assignment for (Coursera) Data Cleaning -- Wisarn Patchoo

This "run_analysis.R" script is for Peer-graded Assignment of week-IV in "Johns Hopkins University  Getting and Cleaning Data Cleaning" course. It processes data from "Human Activity Recognition Using Smartphones Dataset Version 1.0" by Jorge L. Reyes-Ortiz, et. al., See <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
for more information. For future reference, denote that data set as "HARS data set" to create two tidy data set.

- averageDataSet: See averageDataSet-Dict.txt for more information
- combinedDataSet See combinedDataSet-Dict.txt for more information

It has one parameter which is the directory path that HARS data set is located. The following detail describes the operations that are done by the script.

1. Load "dplyr" package for processing data frame.
2. Set appropriate working directory.
3. Load all datasets (subject_train, X_train, y_train, subject_test, X_test, y_test, activity_label, features)
4. For "train" data, obtain column indices corresponds to mean and standard deviation features (46 columns for "train" data and 33 columns for "test" data)
5. Create data frame based on collected indices.
6. Then, for each row of newly data frame in 5., collect corresponding activity from subject number and add them as two more columns in data frame. Note that activity is converted to one of six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
7. Step 4-6 is done similarly for "test" data.
8. Two newly data frames from "train" and "test" data resulted from step 4-7 are combined into one data frame called "combine_data".
9. Corresponding column labels are assigned to "combine_data" data frame. First 79 columns are labeled as shown in ./DataDict/MeanStdfeature.txt and last two columns are labels as activity and subject_no, respectively.
10. Based on "combine_data" data frame, average values of each column for each activity and each subject are computed. Then, "avg_data" data frame is created based on resultd average values.
11. New data frame called "NewDataSet" is created. It is a list composes of two data frames, "combine_data" and "avg_data".
12. "combine_data" data frame is used to create "combinedDataSet.csv". See ./DataDict/combinedDataSet-Dict.txt for more information.
13. "avg_data" data frame is used to create "averageDataSet.csv". See ./DataDict/averageDataSet-Dict.txt for more information.
