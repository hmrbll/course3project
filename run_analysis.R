data_files_directory <- "UCI HAR Dataset"

feature_names_path <- paste(data_files_directory, "features.txt", sep = "/")
feature_names <- read.table(feature_names_path, stringsAsFactors = FALSE)

X_train_path <- paste(data_files_directory, "train", "X_train.txt", sep = "/")
X_train <- read.table(X_train_path, stringsAsFactors = FALSE)

colnames(X_train) <- feature_names[[2]]

X_test_path <- paste(data_files_directory, "test", "X_test.txt", sep = "/")
X_test <- read.table(X_test_path, stringsAsFactors = FALSE)

colnames(X_test) <- feature_names[[2]]