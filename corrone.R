#this file is for splitting the log data 

library(stringr)
LOGS = read.table("C:\\Users\\Sandhya\\Documents\\correlationone\\access.log\\access.log", sep=" ", header=F)
head(LOGS)
attach(LOGS)

LOGS <- data.frame(LOGS)
#And here's a gsub method:
LOGS$type_1 <- gsub("=+$", "", LOGS$V2)
LOGS$ids <- lapply(strsplit(as.character(LOGS$V2),'='), "[", 2)

LOGS$Article_id <- lapply(strsplit(as.character(LOGS$ids),'&'), "[", 1)

head(LOGS)


LOGS$chuma <- lapply(strsplit(as.character(LOGS$V2),'='), "[", 3)


LOGS$User_id <- lapply(strsplit(as.character(LOGS$chuma),' '), "[", 1)

#Mydata <- data.frame(LOGS$v1 , LOGS$V3 , LOGS$V4 , LOGS$Article_id , LOGS$User_id)

#head(Mydata)

class(LOGS)
class(LOGS$V1)
class(LOGS$V2)
class(LOGS$V3)
class(LOGS$V4)
class(LOGS$type_1)
class(LOGS$ids)
class(LOGS$Article_id)
class(my.df$chuma)
class(LOGS$User_id)

my.df <- data.frame(lapply(LOGS, as.character), stringsAsFactors=FALSE)
head (my.df)


write.csv(my.df, file = "accesslog.csv",row.names=FALSE, na="",col.names=TRUE,sep = ",")


