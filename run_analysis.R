library(plyr)
library(MASS)

#Read Test Data
xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")
subjtest <- read.table("test/subject_test.txt")

#Read Train Data
xtrain <- read.table("train/X_train.txt")
ytrain <- read.table("train/y_train.txt")
subjtrain <- read.table("train/subject_train.txt")

#Merge Test and Train Data by rows
x <- rbind(xtest, xtrain)
y <- rbind(ytest, ytrain)
subj <- rbind(subjtest, subjtrain)

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
#write.table(summaryData, "tidy_data.txt", sep="\t", row.names=FALSE)
write.matrix(summaryData, file="tidy_data.txt", sep = "   ")







