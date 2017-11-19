## load packages for later use
library(dplyr)

## Read in the data
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
activity_test <- read.table("y_test.txt")
activity_train <- read.table("y_train.txt")
data_test <- read.table("X_test.txt")
data_train <- read.table("X_train.txt")

## Merge the test and train data
test_data <- cbind(subject_test, activity_test, data_test)
train_data <- cbind(subject_train, activity_train, data_train)
full_data <- rbind(test_data, train_data)

## Select columns with mean() or std() in their names
all_vbls <- read.table("features.txt")[, 2]
vbls <- grep("(mean\\(\\)|std\\(\\))", all_vbls)
col_indices <- vbls + 2
col_indices <- c(c(1,2), col_indices)
mean_std_data <- full_data[, col_indices]

## Label activities with descriptive names
activity_lables <- tolower(read.table("activity_labels.txt" )[, 2]) %>%
                   gsub("_", " ", .)

label_activities <- function(x){activity_lables[x]}
mean_std_data[, 2] <- sapply(mean_std_data[, 2], label_activities)

## Clean up variable names
## Remove special character, separate words and abbreviations
## by points instead of using capitalization
vbl_names <- all_vbls[vbls] %>%
            gsub("^t([A-Z])", "time\\1", .) %>%
            gsub("^f([A-Z])", "freq\\1", .) %>%
            gsub("std\\(\\)", ".std", .) %>%
            gsub("mean\\(\\)", ".mean", .) %>%
            gsub("-", "", .) %>%
            gsub("([a-z])([A-Z])", "\\1\\.\\2", .) %>%
            tolower(.) %>%
            gsub("body.body", "body", .) %>%
            gsub("acc.jerk", "linear.jerk", .) %>%
            gsub("gyro.jerk", "angular.jerk", .) %>%
            gsub("acc", "linear.acc", .) %>%
            gsub("gyro", "angular.acc", .) 

colnames(mean_std_data) <- c(c("subject.id", "activity"), vbl_names)

mean_std_data <-group_by(mean_std_data, subject.id, activity) %>%
           summarise_all(mean)

write.table(mean_std_data, file = "tidy_dataset.txt", row.names = FALSE)


