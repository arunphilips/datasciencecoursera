## Code Book 

### Data Scource

Source of data - 	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Full description of data -	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
	
### Steps

The R Script 'run_analysis.R' performs these 6 tasks and also creates a final tidy data set.

1) The script first reads in the test and train data for subject, activity and measurements and combines these.

2) The script then names the measurements from the data in feature names file.

3) Data of only mean and standard deviation measurements is extracted.

4) Activity numbers replaced with Activity Names.

5) The variable names are given more descriptive names.

6) Average of measurements according to activity and subjects are separated into a new data set.

### Variables

  "activitylabels" - Labels of activity names
  
  "activitytest" - Activities in test file
  
  "activitytrain" - Activities in test file
  
  "allactivity" - Combined Activities
  
  "alldata" - Combined Data set 
  
  "allsubject" - Combined Subject set 
  
  "datasep" - Separated mean and std deviation measurements      
  
  "datatest"  - test data     
  
  "datatrain" -  train data      
  
  "featurenames"   - Names of Measurements
  
  "filepath"    - File Path of Data
  
  "finaldata"  - Final data set    
  
  "meanstd"        - Mean and Standard deviation Feature names
  
  "onlymeansd"     - Only mean and std deviation data
  
  "subjecttest"   - Subject data of test
  
  "subjecttrain"   - Subject data of train
  
  "tidydata"      - Tiday data set, averages of measurements for subjects and activities

### Output

 Output file - tidydata.txt
- The first column contains subject numbers.
- The second column contains activity names.
- The remaining 172 columns are the measurements.


