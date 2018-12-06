#Assign directory of data files to a variable
data_files_directory <- "UCI HAR Dataset"
#Get feature names
feature_names_path <- paste(data_files_directory, "features.txt", sep = "/")
feature_names <- read.table(feature_names_path, stringsAsFactors = FALSE)
#Get measurements of training set
X_train_path <- paste(data_files_directory, "train", "X_train.txt", sep = "/")
X_train <- read.table(X_train_path, stringsAsFactors = FALSE)
#Assign feature names to measurements of training set
colnames(X_train) <- feature_names[[2]]
#Get measurements of test set
X_test_path <- paste(data_files_directory, "test", "X_test.txt", sep = "/")
X_test <- read.table(X_test_path, stringsAsFactors = FALSE)
#Assign feature names to measurements of test set
colnames(X_test) <- feature_names[[2]]
#Get activities of training set
y_train_path <- paste(data_files_directory, "train", "y_train.txt", sep = "/")
y_train <- read.table(y_train_path, stringsAsFactors = FALSE)
y_train <- as.factor(y_train$V1)
#Get activity labels
activity_labels_path <- paste(data_files_directory, "activity_labels.txt", sep = "/")
activity_labels <- read.table(activity_labels_path, stringsAsFactors = FALSE)
#Insert activity labels 
levels(y_train) <- activity_labels[[2]]
#Combine training set into single data set
train <- cbind(X_train, y_train)
colnames(train)[[ncol(train)]] <- "Activity"
#Get activities of test set
y_test_path <- paste(data_files_directory, "test", "y_test.txt", sep = "/")
y_test <- read.table(y_test_path, stringsAsFactors = FALSE)
y_test <- as.factor(y_test$V1)
#Insert activity labels
levels(y_test) <- activity_labels[[2]]
#Combine test set into single data set
test <- cbind(X_test, y_test)
colnames(test)[[ncol(test)]] <- "Activity"
#Combine training and test sets
all_data <- rbind(train, test)
#Remove remaining files
rm(list=ls()[!ls() %in% "all_data"])
#Select mean and standart deviation measurements
only_mean_and_std <- grepl('-(mean|std)\\(', colnames(all_data))
selector <- c(which(only_mean_and_std), ncol(all_data))
selected_data <- all_data[selector]

data_files_directory <- "UCI HAR Dataset"

subject_train_path <- paste(data_files_directory, "train", "subject_train.txt", sep = "/")
subject_train <- read.table(subject_train_path, stringsAsFactors = FALSE)

subject_test_path <- paste(data_files_directory, "test", "subject_test.txt", sep = "/")
subject_test <- read.table(subject_test_path, stringsAsFactors = FALSE)

subject <- rbind(subject_train, subject_test)

all_data <- cbind(subject, all_data)
selected_data <- cbind(subject, selected_data)

colnames(all_data)[[1]] <- "subject"
colnames(selected_data)[[1]] <- "subject"

rm(list=ls()[!ls() %in% "selected_data"])
means <- grepl('mean\\(', colnames(selected_data))

for(i in 1:length(colnames(selected_data))) {
        if(means[i]) {
                colnames(selected_data)[i] <- paste("Average", colnames(selected_data)[i], sep = " ")
        }
}

colnames(selected_data) <- gsub("-mean\\(\\)", "", colnames(selected_data))

standart_deviations <- grepl('std\\(', colnames(selected_data))

for(i in 1:length(colnames(selected_data))) {
        if(standart_deviations[i]) {
                colnames(selected_data)[i] <- paste("Standart Deviation", colnames(selected_data)[i], sep = " ")
        }
}

colnames(selected_data) <- gsub("-std\\(\\)", "", colnames(selected_data))

colnames(selected_data) <- gsub("(^.+) t", "\\1 Time ", colnames(selected_data))
colnames(selected_data) <- gsub("(^.+) f", "\\1 Frequency", colnames(selected_data))