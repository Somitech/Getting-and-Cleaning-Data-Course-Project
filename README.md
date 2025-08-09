# Getting and Cleaning Data: Course Project

This repository contains my submission for the "Getting and Cleaning Data" course project. The goal of this project is to take a raw dataset from a human activity study and transform it into a clean, tidy dataset ready for analysis.

## About the Dataset

The data comes from the "Human Activity Recognition Using Smartphones Dataset" study. In this study, 30 volunteers performed six different activities (like Walking, Sitting, Laying) while wearing a smartphone. The phone's accelerometer and gyroscope data were captured to record their movements.

* **Data Source:** [Link to the dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## The `run_analysis.R` Script

The R script included in this repository, `run_analysis.R`, handles all the data processing. When run, it performs the following five steps:

1.  **Merges Data:** Combines the training and test datasets into a single, unified dataset.
2.  **Extracts Key Measurements:** Pulls out only the measurements for the mean and standard deviation for each signal.
3.  **Adds Descriptive Activities:** Replaces the numeric activity codes with descriptive names (e.g., changes `1` to `WALKING`).
4.  **Labels Variables Clearly:** Cleans up the variable names to make them readable and descriptive.
5.  **Creates a Tidy Summary:** From the main dataset, it creates a second, independent tidy dataset that shows the average of each variable for each unique combination of subject and activity.

## How to Run This Project

1.  Download the raw data from the link above.
2.  Unzip the data folder and ensure it's in your R working directory. The script expects a folder named `UCI HAR Dataset`.
3.  Run the R script by typing `source("run_analysis.R")` in your R console.

The script will generate a new file in your directory called `TidyData.txt`, which is the final, tidy summary dataset.

For a detailed explanation of the variables and transformations, please refer to the `CodeBook.md` file.
