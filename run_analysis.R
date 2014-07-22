library(plyr)

#Read Test Data
xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")
subjtest <- read.table("test/subject_test.txt")
body_acc_xtest <- read.table("test/Inertial Signals/body_acc_x_test.txt")
body_acc_ytest <- read.table("test/Inertial Signals/body_acc_y_test.txt")
body_acc_ztest <- read.table("test/Inertial Signals/body_acc_z_test.txt")
body_gyro_xtest <- read.table("test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_ytest <- read.table("test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_ztest <- read.table("test/Inertial Signals/body_gyro_z_test.txt")
tot_acc_xtest <- read.table("test/Inertial Signals/total_acc_x_test.txt")
tot_acc_ytest <- read.table("test/Inertial Signals/total_acc_y_test.txt")
tot_acc_ztest <- read.table("test/Inertial Signals/total_acc_z_test.txt")

#Read Train Data
xtrain <- read.table("train/X_train.txt")
ytrain <- read.table("train/y_train.txt")
subjtrain <- read.table("train/subject_train.txt")
body_acc_xtrain <- read.table("train/Inertial Signals/body_acc_x_train.txt")
body_acc_ytrain <- read.table("train/Inertial Signals/body_acc_y_train.txt")
body_acc_ztrain <- read.table("train/Inertial Signals/body_acc_z_train.txt")
body_gyro_xtrain <- read.table("train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_ytrain <- read.table("train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_ztrain <- read.table("train/Inertial Signals/body_gyro_z_train.txt")
tot_acc_xtrain <- read.table("train/Inertial Signals/total_acc_x_train.txt")
tot_acc_ytrain <- read.table("train/Inertial Signals/total_acc_y_train.txt")
tot_acc_ztrain <- read.table("train/Inertial Signals/total_acc_z_train.txt")

#Merge Test and Train Data by rows
x <- rbind(xtest, xtrain)
y <- rbind(ytest, ytrain)
subj <- rbind(subjtest, subjtrain)
body_acc_x <- rbind(body_acc_xtest, body_acc_xtrain)
body_gyro_x <- rbind(body_gyro_xtest, body_gyro_xtrain)
body_acc_y <- rbind(body_acc_ytest, body_acc_ytrain)
body_acc_z <- rbind(body_acc_ztest, body_acc_ztrain)
body_gyro_y <- rbind(body_gyro_ytest, body_gyro_ytrain)
body_gyro_z <- rbind(body_gyro_ztest, body_gyro_ztrain)
tot_acc_x <- rbind(tot_acc_xtest, tot_acc_xtrain)
tot_acc_y <- rbind(tot_acc_ytest, tot_acc_ytrain)
tot_acc_z <- rbind(tot_acc_ztest, tot_acc_ztrain)

# Read the features/variables file
features <- read.table("features.txt")

#Update variable names in x with actual feature measurements
names(x) <- features[,2]

#Extract from x only measurements for mean() and std() calculations
meanstdx <- x[,grep("-mean\\(\\)|-std\\(\\)", colnames(x))]

#Replace y activity data from numeric to factor to provide with descriptive 
#activity labels instead of numbers
activity <- read.table("activity_labels.txt")
y[,1] <- factor(y[,1], levels = activity[,1], labels=activity[,2])

#Replace Activity column name in y with descriptive label
names(y) <- "activityName"

#Replace Subject column name with descriptive label
names(subj) <- "subject"

#Merge activity, subject and x measurements into a single data set
x_all <- cbind(subj, y, meanstdx)

#Summarize measurements based on activity and subjects and calculate mean of all
#values
summaryData <- ddply(x_all, .(subject,activityName), numcolwise(mean))

#Write the tidy data to a file
write.table(summaryData, "tidy_data.txt", sep="\t", row.names=FALSE)







