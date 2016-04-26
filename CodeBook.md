#Code book  for Getting Cleaning Data
-------------------------------------

The script file run_analysis.R performs all the 5 steps mentioned in the course project. 
first of the script downloads and unzips the dataset and required files are fed and load into different variables.

1. Then, similar data are merged using rbind() function. e.g. Training and test data of X, Y and subject are merged.
2. Columns with meaures MEAN and STANDARD DEVIATION are extracted from the dataset. Appropriate names are updated from `features.txt` file in the obtained dataset.
3. From the `activity_labels.txt` file, corresponding activites are updated in the dataset. (Available activites are:  WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
4. Dataset is labeled in a descriptive way:
	- `tBodyAcc-mean()-X` becomes `timeBodyAccMeanX` 
	- `tBodyAcc-std()-Y` becomes `timeBodyAccStdY`
	- `fBodyAcc-mean()-Z` becomes `freqBodyAccMeanZ`
	- `fBodyBodyGyroMag-mean()` becomes `freqBodyGyroMagMean`
	- `fBodyBodyGyroJerkMag-meanFreq()` becomes `freqBodyGyroJerkMagMeanFreq`
5. Independent tidy dataset with mean value for each subject and activity is generated. The output file is `clean_data.txt` and is available in this repo.

##Description of Variables
1. dataTest, dataTest_Y, dataTrain, dataTrain_Y , dataTestSubject and dataTrainSubject  contain the loaded data from the downloaded files.
2. dataAll_X, datAll_Y  and dataAllSubject merge the previous datasets mentioned in step 1.
2. dataFeatures contains the file `features.txt`. meanStd contains all the columns having literal 'mean' or 'std'. 
3. dataActivities contains the file `activity_labels.txt`. Correct activity name is updated from here.
4. allData merges dataAll_X, datAll_Y  and dataAllSubject into a single dataset. Comprehensive names are updated in the dataset.
5. And finally, avg contains the corresponding averages which is finally stored in `cleaned_data.txt` file.