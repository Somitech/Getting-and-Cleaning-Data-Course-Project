# CodeBook: Tidy Data for Human Activity Recognition

This codebook describes the variables, data, and transformations performed to create the final tidy dataset (`TidyData.txt`) for the "Getting and Cleaning Data" course project.

## Source Data

The data was originally collected for the "Human Activity Recognition Using Smartphones Dataset". It was generated from experiments with 30 volunteers who performed six activities while wearing a smartphone. The phone's accelerometer and gyroscope captured 3-axial linear acceleration and angular velocity. For more details on the original data collection, please refer to the `README.txt` file in the source data folder.

## The Tidy Dataset (`TidyData.txt`)

The `run_analysis.R` script produces a final tidy dataset that contains the **average of each mean and standard deviation measurement for each subject and each activity**.

The resulting dataset has **180 rows** (30 subjects * 6 activities) and **88 columns**.

### Identifier Variables

The first two columns identify each unique observation:

* **Subject**: An integer from 1 to 30, identifying the volunteer who participated in the experiment.
* **Activity**: A descriptive name for one of the six activities performed.
    * `LAYING`
    * `SITTING`
    * `STANDING`
    * `WALKING`
    * `WALKING_DOWNSTAIRS`
    * `WALKING_UPSTAIRS`

### Measurement Variables

The remaining 86 columns are the features whose averages were calculated. The variable names have been cleaned to be more descriptive:

* The leading `t` and `f` from the original data were expanded to `Time` and `Frequency`.
* Abbreviations like `Acc`, `Gyro`, `Mag` were expanded to `Accelerometer`, `Gyroscope`, and `Magnitude`.
* Parentheses `()` were removed, and hyphens `-` were converted to a dot `.` for readability in R.
* The final variable names indicate that they are the average of the original measurement (e.g., `TimeBodyAccelerometer.mean.X` is the average for that measurement across a specific subject and activity).

Here is a full list of the measurement variables:

* `TimeBodyAccelerometer.mean.X`
* `TimeBodyAccelerometer.mean.Y`
* `TimeBodyAccelerometer.mean.Z`
* `TimeBodyAccelerometer.std.X`
* `TimeBodyAccelerometer.std.Y`
* `TimeBodyAccelerometer.std.Z`
* ... (and so on for all 86 measurement columns) ...
* `FrequencyBodyBodyGyroscopeJerkMagnitude.mean`
* `FrequencyBodyBodyGyroscopeJerkMagnitude.std`

Each of these columns contains a numeric value representing the average of that measurement for the corresponding Subject and Activity.
