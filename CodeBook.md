# Code Book

## RAW Data

As RAW data used [UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) dataset. It contains itself information about containing data, but I write here most valuable part. Full information about data structure provided in `README.txt` file in data archive.

The experiments have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. Using its embedded accelerometer and gyroscope, was captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals extremely wide, but in course project only two used: 

* mean(): Mean value
* std(): Standard deviation

## Data Loading and postrocessing

Function `loadData()` used to load RAW dataset into memory. It downloads arcive with RAW data into `./data` directory and unpack it. Helper function `readDataFromCat()` used for separate loading from test and training data sets.

For processing data used function `processData()`. It loads data in dataset, then extract columns with mean and standard deviation values. For each subject and each activy code calculates average value. Resulting dataframe with tidy data saved in file tidy.txt
