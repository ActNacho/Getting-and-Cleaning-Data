#Getting and Cleaning Data 
##Course Project CodeBook
This file describes the variables and the data related to the work of the script run_analysis.R

* The source of the study is this website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      

* The data was downloaded from:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

* The run_analysis.R script performs the following steps to clean the data:   
 1. Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in *Xtrain*, *Ytrain* and *Strain* variables respectively.       
 2. Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in *Xtest*, *Ytest* and *Stest* variables respectively.  
 3. Merge the X data (Variable Values) together, the same for the Y data (Labels) and the S data (Subjects)
 4. At the end of every step, the script removes objects from the environment that will no longer be used.
 5. Take the features name from the features.txt and put the names in the columns form X.
 6. Substitute the activities names instead of the number values in Y.
 7. Combine together all the columns from the S, Y and X. (This is complete and tidy data, stored in cleanedData)
 8. From all the data, we "filter" the observations for each activity and each subject. With those observations the mean is determined and stored as a single value for all the combination(subject,activity)
 9. A text file is created with the final data exported. ("tidy_data_step5.txt")
 
© Ignacio Trujillo 2015 All Rights reserved.
