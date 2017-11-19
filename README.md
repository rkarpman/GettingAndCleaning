### Data Cleaning Project: Wearable Computing
***
#### Author: Rachel Karpman



This analysis uses the dataset _Human Activity Recognition Using Smartphones_, 
which contains the data for the following publication.

>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
using a Multiclass Hardware-Friendly Support Vector Machine. 
International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012.

The original data was collected during a series of experiments 
with 30 volunteers, performing one of six activities 
(such as sitting or walking upstairs) while wearing a smartphone (a Samsung Gallaxy S II).
 Using the phone's sensors, researchers collected 3-axial linear
 and angular acceleration data for each subject;
 and computed a number of attributes for each component 
of the measured acceleration.

The script `run_analysis.R` produces a tidy dataset containing
the average values of the mean and
standard deviation of various features of the acceleration data for 
each subject and each activity. 

To run the script, the user must have the following files from the 
original dataset in their working directory:

* `activity_labels.txt`: lookup table indexing activity names with integers
* `features.txt`: lookup table giving the variable name for each column of the acceleration data
* `subject_test.txt`: single column of integers giving a subject id for each 
trial in the test data
* `subject_train.txt`: single column of integers giving a subject id for each trial in the training data
* `y_test.txt`: single column of integers giving an activity label for each trial in the test data
* `y_train.txt`: single column of integers an activity label for each trial in 
the training set
* `X_test.txt`: table giving a 561-element feature vector for 
each trial in the testing set
* `X_train.txt`: table giving a 561-element feature vector for 
each trial in the training set


In the original dataset, the files with names ending in "test" and "train" 
are found in the "test" and "train" folders, respectively.

The `dplyr` package must be installed to run the script.

The output is written to a file `tidy_dataset.txt` which can be read using the 
 command
    
```
read.table("tidy_dataset.txt", head = TRUE)
```
  
Sourcing the script `run_analysis.R` does the following:

1. Merges the test and training data into a single dataframe.
2. Replaces the integers in the second column with descriptive activity labels.
3. Selects only the columns corresponding to the mean or standard deviation
of some measured quantity; that is, those whose original labels 
include the substring `mean()` or `std()`.
4. Labels the columns with descriptive variable names.
5. Groups the data first by subject, then by activity, and 
takes the mean of each column within each group. 
6. Writes the resulting table to a text file `tidy_dataset.txt`

For easier reading, the script makes several changes to the activity labels 
and variable names from the original dataset. The new names are described in the codebook.
