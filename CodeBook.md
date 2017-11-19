### Data Cleaning Assignment: Wearable Computing
***
### Codebook
#### Author: Rachel Karpman


### The Original Dataset 

This analysis uses the dataset _Human Activity Recognition Using Smartphones_, 
which contains the data for the following publication.

>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
using a Multiclass Hardware-Friendly Support Vector Machine. 
International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012.

We briefly describe the researchers' method of collecting and processing data, as described in the file `README.txt` which accompanies the original data.

The data was obtained from experiments carried out with a group of 30 
volunteers.  Each person performed six activities (walking, walking upstairs, 
walking downstairs, sitting, laying, and standing) wearing a smartphone 
(Samsung Galaxy S II) on the waist. 
Using the phone's embedded accelerometer and gyroscope, the 
researchers captured 3-axial linear acceleration and 3-axial angular velocity. 

The 3-axial linear and angular velocity signals were split into two components,
one corresponding to body motion and the other to gravity.  The magnitude of 
each component was computed; as was the derivative of each component
with respect to time. In addition, a Fast Fourier Transform (FFT) was applied to the components of acceleration due to body movement, to create new variables in the freqency domain.

The researchers then applied a number of different functions, including mean and standard deviation, to each of the
features described above. 

### Analysis

The researches randomly partitioned their data into two sets, where 70% of the 
volunteers was selected for generating the training data and 30% the test data. 
For this analysis, the testing and training datasets were merged to form a single dataframe.
The columns corresponding to the mean or standard deviation of each feature described in the previous section were then selected.
The average value of each of the selected variables was computed for each subject and each activity.
The result is a tidy dataset, with each row representing one subject and one activity.

The analysis is contained in a single script, called `run_analysis.R` which does the following:

1. Merges the test and training data into a single dataframe.
2. Replaces the integer values used to label activities with descriptive text labels.
3. Selects only the columns corresponding to the mean or standard deviation of desired features.
4. Labels the columns with descriptive variable names.
5. Groups the data first by subject, then by activity, and 
takes the mean of each column within each group. 
6. Writes the resulting table to a text file `tidy_dataset.txt.`

For details on running the script, see the file `README.md` that accompanies this analysis.

More information about each step is given below.

#### (1) Assembling the data:

We assemble the test data into a single dataframe by 
placing subject identifiers in the first column, activity labels in the second,
and features in the remaining columns.  We do the same for 
the training data, then merge the two data frames by stacking
them vertically.

#### (2) Creating descriptive activity labels

For easier reading, the text labels have been converted 
from all uppercase to all lowercase, and underscores between words 
were replaced with spaces.

#### (3) Selecting columns

We select only the columns whose original names include the tokens `mean()` or `std()`.  

#### (4) Creating and editing variable names: 

In the provided dataset, variable names for each feature were created
by combining a small number of words and abbreviations, 
such as `acc` for acceleration. This basic convention has been preserved, 
with the following changes.

In the original dataset, all variable names are in camelcase, with a 
capital letter denoting the start of a new token. To avoid potential issues 
caused by capital letters during analysis, 
all variable names were converted to lowercase, 
with periods inserted between tokens. 
The special characters `(`, `)` and `-` were removed. 

The tokens`t` and `f`, indicating variables with domain time and frequency respectively, were replaced by the more-descriptive 
`time` and `freq`.

The tokens `acc` and `acc.jerk`, which represent linear acceleration and linear jerk, 
were replaced with `linear.acc` and `linear.jerk`. Similarly, `gyro` and `gyro.jerk` were replaced by the more descriptive `angular.acc` and `angular.jerk`.

Finally, `body.body`, which appears to be the result typographical error, 
was replaced with `body` wherever it appeared. 

#### (5) Grouping and summarizing the data:

Each row of the final dataset represents a single observation, corresponding to
a unique choice of subject and activity. Hence, the final dataset is tidy.

### Summary of variable names and values

#### (1) The `subject.id` column.

Values are integers from 1 to 30.  Each integer represents a different test subject.
    
#### (2) The `activity` column.

Text labels for the six activities performed by the volunteers:
    
* laying
* sitting
* standing
* walking
* walking downstairs
* walking upstairs
        
#### (3) Remaining columns

Each feature variable is composed of a sequence of tokens, which combine to give
a compact description of the quantity the feature represents.
    
We take the average values of each variable for each subject and each activity.
For example, the variable `time.body.linear.acc.mean.std.x` represents the standard deviation of the x-component of linear acceleration due to body movement, averaged over each trial involving a given subject and activity.
    
##### Normalization and units

All variable are normalized, so that values are in the range [-1, 1].
    
Units for time-domain variables:

* **linear acceleration:** standard gravitational units $g$. 
* **linear jerk:** gravitational units per second
* **angular acceleration:** radians per second 
* **angular jerk:** radians per second per seond

Units for frequency-domain variables are not explicity given, and are assumed to be Hz (cycles per second).

##### Components of feature names

* **time:** denotes variables whose domain is time; these are the measured components of acceleration
* **freq:** variables whose domain is frequency; obtained from time-domain variables by applying an FFT.
* **body:** component due to body movement
* **gravity:** component due to gravity
* **linear.acc:** linear accleration
* **angular.acc:** angular acceleration
* **linear.jerk:** time derivative of linear acceleration
* **angular.jerk:** time derivative of angular acceleration
* **mag:** euclidean norm of a 3-dimensional vector
* **mean:** mean
* **std:** standard deviation
* **x:** component in the x-direction
* **y:** component in the y-direction.
* **z:** component in the z-direction.
    
    
    


