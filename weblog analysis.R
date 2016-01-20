#loading the csv file 
file <- read.csv("accesslog.csv",na.strings=c("NA", "NULL"))
head(file)
dim(file)
summary(file)

#splitting training and test set 

library(AppliedPredictiveModeling)
library(caret)

Training <- createDataPartition(file$Article_id ,p = 3/4)[[1]]
trainData <- file[ Training,]
testData <- file[-Training,]

dim(trainData)
dim(testData)

#creating scatter plot for the data
attach(trainData)
plot(Article_id, User_id, main="Scatterplot Example",xlab="Article_id ", ylab="User_id ", pch=19) 


#plotting the status code of 200 and 400 

table(file[,2])
barplot(table(file[,2]))

#changing the data format to analyse more on the day the users click on the lick 
newV4 <- strptime(file$date, format='[%d/%b/%Y:%H:%M:%S]')
#formatting the day 
day = format(newV4, "%A")
unique(day)
head(day)

#formatting the hours
hours = format(newV4, "%H")
head(hours)

#ploting the data on days  for better understanding when the users are active
barplot( table(factor(day, levels=c("Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday", "Sunday"))), xlab="Day", ylab="Count",col="red", border="blue", main='Visits Per Weekday')

#plotting the hour to see the active time 
barplot(table(hours), xlab="Hour", ylab="Count", col="lightgreen",las=2, border="gray")


#creating temfile to merge with the data from db
tempfile <- file
head(tempfile)

#tempfile$date <- NULL
tempfile$status <- NULL
tempfile$bytes.transferred <- NULL

#assiginig null values to the test data to plot correlation 
testData$date <- NULL
testData$status <- NULL
testData$bytes.transferred <- NULL
head(testData)

#plotting correlation of the data 

x <- cor(testData)

library(corrplot)
corrplot(x)

