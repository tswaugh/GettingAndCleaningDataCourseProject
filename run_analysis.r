#Load dplyr
library("dplyr")

#Load dataset information: column names and activity labels
column_names <- read.table(file.path(".","UCI HAR Dataset/features.txt"), col.names = c("Column Index","Column Name"))
activity_labels <- read.table(file.path(".","UCI HAR Dataset/activity_labels.txt"),col.names = c("Activity Index","Activity Label"))

# Get columns with mean and standard deviation
required_columns <- column_names[grep("mean|std", column_names$Column.Name),"Column.Index"]

#Load test summary dataset with column names
x_test <- read.table(file.path(".","UCI HAR Dataset/test/X_test.txt"),col.names = column_names$Column.Name)

#Load activity list for test dataset
y_test <- read.table(file.path(".","UCI HAR Dataset/test/y_test.txt"),col.names = c("activity"))

#Load test subject labels
subject_test <- read.table(file.path(".","UCI HAR Dataset/test/subject_test.txt"),col.names = c("subject.ID"))

#Convert test activity labels into factor data
y_test$activity <- factor(y_test$activity,levels = as.numeric(activity_labels$Activity.Index) , labels = activity_labels$Activity.Label)

#Load test summary dataset with column names
x_train <- read.table(file.path(".","UCI HAR Dataset/train/X_train.txt"),col.names = column_names$Column.Name)

#Load activity list for train dataset
y_train <- read.table(file.path(".","UCI HAR Dataset/train/y_train.txt"),col.names = c("activity"))

#Load train subject labels
subject_train <- read.table(file.path(".","UCI HAR Dataset/train/subject_train.txt"),col.names = c("subject.ID"))

#Convert activity labels into factor data
y_train$activity <- factor(y_train$activity,levels = as.numeric(activity_labels$Activity.Index) , labels = activity_labels$Activity.Label)

#Extract required columns from both datasets
x_train <- x_train[,required_columns]
x_test <- x_test[,required_columns]

#Add activity and subject labels to both datasets
test_combined <- cbind(subject_test,y_test$activity,x_test)
train_combined <- cbind(subject_train,y_train$activity,x_train)

#Rename activity column
names(test_combined)[2] <- "activity"
names(train_combined)[2] <- "activity"

#Combine test and train datasets
combinedUHIHARData <- rbind(test_combined,train_combined)

#Extract mean of each column grouped by subject and activity type
groupedSummary <- combinedUHIHARData %>% group_by(subject.ID,activity) %>% summarise_each(funs(mean))

#Write files out to CSV dropping row names
write.table(groupedSummary,file = "UCI_HAR_Summarized_by_subject_activity.txt",row.names = FALSE)
write.table(combinedUHIHARData,file = "UCI_HAR_Combined_Unsumarized.txt",row.names = FALSE)