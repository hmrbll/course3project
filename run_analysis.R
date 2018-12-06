data_files_directory <- "UCI HAR Dataset"

feature_names_path <- paste(data_files_directory, "features.txt", sep = "/")
feature_names <- read.table(feature_names_path, stringsAsFactors = FALSE)

X_train_path <- paste(data_files_directory, "train", "X_train.txt", sep = "/")
X_train <- read.table(X_train_path, stringsAsFactors = FALSE)

colnames(X_train) <- feature_names[[2]]

X_test_path <- paste(data_files_directory, "test", "X_test.txt", sep = "/")
X_test <- read.table(X_test_path, stringsAsFactors = FALSE)

colnames(X_test) <- feature_names[[2]]

y_train_path <- paste(data_files_directory, "train", "y_train.txt", sep = "/")
y_train <- read.table(y_train_path, stringsAsFactors = FALSE)
y_train <- as.factor(y_train$V1)

activity_labels_path <- paste(data_files_directory, "activity_labels.txt", sep = "/")
activity_labels <- read.table(activity_labels_path, stringsAsFactors = FALSE)

levels(y_train) <- activity_labels[[2]]

train <- cbind(X_train, y_train)
colnames(train)[[ncol(train)]] <- "Activity"

y_test_path <- paste(data_files_directory, "test", "y_test.txt", sep = "/")
y_test <- read.table(y_test_path, stringsAsFactors = FALSE)
y_test <- as.factor(y_test$V1)

levels(y_test) <- activity_labels[[2]]

test <- cbind(X_test, y_test)
colnames(test)[[ncol(test)]] <- "Activity"

all_data <- rbind(train, test)

rm(list=ls()[!ls() %in% "all_data"])

only_mean_and_std <- grepl('-(mean|std)\\(', colnames(all_data))
selector <- c(which(only_mean_and_std), ncol(all_data))
selected_data <- all_data[selector]