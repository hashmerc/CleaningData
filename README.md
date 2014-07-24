Getting and Cleaning Data
============

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The script used for getting and cleaning data is called **run_analysis.R** 

*Note:* 
All the files under the sub folder Intertial Signals were ignored as they were not applicable for obtaining the required tidy data set for this course project. 

The run_analysis.R script is divided into multiple sections as explained below:

### Reading Test and Train Data
  * xtest variable is used to store the data from the *test/X_test.txt* file. 
  * ytest variable is used to store the data from the *test/y_test.txt* file. 
  * subjtest variable is used to store the data from the *test/subject_test.txt*. 
  * Similarly the training data set files were read into xtrain, ytrain and subjtrain variables. 

### Merging Test and Train Data
  * xtest and xtrain data was merged by rows using the rbind function in R and stored in x variable. 
  * Similarly ytest, ytrain and subjtest, subjtrain were merged using rbind function into y and subj variables. 

### Adding Descriptive names to the variables
  * As x contains 561 columns for various measurements and the features files has the information for the column names, *features.txt* file was read into the features variable. 
  * This features vector was then assigned to the column names for x data set. 

### Extracting only the mean and std measurement columns
  * For achieving this requirement, grep function was used within R to read only those columns that have std() and mean() functional associated with it. 
  * This data set was now stored in meanstdx variable. 

### Cleaning y and subj data set
  * Activity Labels was read from the *activity_labels.txt* file and then the y dataset was modified to convert the column values to factor using the values and label names extracted from the activity file. 
  * Finally a descriptive column name was added to the y and subj data set. 

### Merging y, subj and meanstdx data set 
  * A final large raw data set was created by merging all datasets by columns using the cbind function in R. 
  * This was stored in the x_all variable. 

### Summarizing measurements based on subject and activity
  * In order to summarize the dataset based on the subject and activity data, ddply function was used from package **plyr**. 
  * This function used numcolwise function to take the mean of all the numeric columns in the dataset (66 numeric measurement columns). 

### Write tidy data to file
  * Finally this tidy data set was written to a file called tidy_data.txt. 
  * The function write.matrix was used from package **MASS** to help add uniform padding spaces between column values. This allows the file to be more user friendly while viewing the data. 


