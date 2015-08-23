Readme for run_analysis.R script
=================================

This script is designed to transform a set acceleration and velocity data into a tidy data set that can be easily analyzed. The dataset was obtained from the University of California, Irvine's Machine Learning Repository.  The initial dataset consists of 10,299 samples of 561 variables and is split into training and testing sets.  The data was collected from the smartphones of a group of 30 volunteers who each performed 6 actvities (walking, walking upstairs, walking downstairs, sitting, standing, and laying) while wearing the smartphone attached to their waste.

This script assumes that the data has already been downloaded from UCI's website into the working directory.  It also assumes that the file structure from the website's zip file has remained intact.

1.  The first part of the script reads all of the training and testing datasets from the UCI HAR Dataset folder.  This comprises a total of 6 text files of tabular data: subject (which identifies the subject number), y (which identifies the activity being performed with the numerical codes described in the readme documentation for the data), and y (the 561 variables recorded for each of the samples that are detailed in the readme documentation for the data) for both the training set and the testing set.

2.  The second part of the script merges the 6 different datasets into one large, complete dataset.

3.  The third part of the script extracts from the dataset only those variables that measure the mean or standard deviation of a measurement.  These variables were selected by referencing the "features.txt" file from the UCI file and finding all variables that had either "mean" or "std' in the variable name.  A total of 79 variables were selected.  These 79 variables were combined with the Subject and Activity variables to create a data frame with a total of 10,299 samples and 81 variables.

4.  The fourth part of the script replaces the column of activity codes with the names of the activities utilizing the following translation provided by the "activity_labels.txt" file included in the download:

	1 = Walking
	2 = Walking Upstairs
	3 = Walking Downstairs
	4 = Sitting
	5 = Standing
	6 = Laying

5.  The fifth part of the script changes the names of the variable columns to better describe what each variable represents.  The new variable names were generated based on the variable descriptions in the "features.txt" file included in the download.  In addition, the subject variable column is renamed "Subject" and the y variable column is renamed "Activity".

6.  The sixth part of the script uses the dplyr package to create a new data frame that contains the mean of each of the selected variables in the data frame for every combination of Subject and Activity.  This data frame consists of 180 rows and 81 colummns.

7.  The last part of the script creates a file named "summarized_data.txt" in the working directory.  This file contains the output of the data frame created in the previous part of the script.  The file can be read in R with the standard read.table function with header=TRUE. 