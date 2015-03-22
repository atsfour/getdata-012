library("dplyr")
library("tidyr")

variable_names <- c(read.table("./UCI HAR Dataset/features.txt", colClasses = c("numeric", "character"))$V2)

test_data <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = variable_names)
test_activities_idx <- read.table("./UCI HAR Dataset/test/y_test.txt")$V1
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")$V1

train_data <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = variable_names)
train_activities_idx <- read.table("./UCI HAR Dataset/train/y_train.txt")$V1
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")$V1

all_data <- bind_rows(test_data, train_data)
all_activities_idx <- c(test_activities_idx, train_activities_idx)
all_subjects <- c(test_subjects, train_subjects )

# Mission1 Complete

selected_col <- grep(".+(mean|std)\\(\\).*", variable_names)

all_data_selected <- select(all_data, selected_col)

# Mission2 and Mission4 Complete

activity_names <- c(read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = c("numeric", "character"))$V2)
all_activities <- activity_names[all_activities_idx]

# Mission3 Complete

summery <- all_data_selected %>% mutate(activity = all_activities, subject = all_subjects) %>% group_by(subject, activity) %>% summarise_each(funs(mean))

write.table(summery, file="answer.txt", row.name = FALSE)
