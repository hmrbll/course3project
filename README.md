# Getting and Cleaning Data Course Project

The goal of this project is to collect and clean a data set.

UCI HAR Dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Explanation of run_analysis.R

This R script gets inputs from data set. Features of training and test sets, activity names, subjects of training and test sets. Creates subset of original data set with average and standart deviation data. Modifies column names to be more clean for explatory analysis. And as an output run_analysis.R script creates output.txt file which consists of averages of each measurement in subset for each subject and activity.
