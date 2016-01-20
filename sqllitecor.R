library(sqldf)
#connecting to SQL db and joining the tables to fetch the type id and topic id 

db <- dbConnect(SQLite(), dbname=("C:\\Users\\Sandhya\\Documents\\correlationone\\content_digest.db\\contentDiscovery.db"))

dbListTables(db)
dbListFields(db, "articles") 

p <- dbGetQuery(db,"select * from articles")

'''
query <- dbGetQuery(db,"select distinct u.user_id , u.email, em.content_id ,
                    em.email_id , a.article_id ,a.author_id , top.topic_id , 
                    t.type_id ,top.name,t.name typename from 
                    users u , 
                    email_content em,
                    articles a,
                    types t,
                    topics top
                    where  u.user_id = em.user_id
                    and em.article_id = a.article_id 
                    and a.type_id = t.type_id 
                    and a.topic_id = top.topic_id
                    ") 
'''

article <- dbGetQuery(db," select distinct a.article_id,top.topic_id,t.type_id
                          from 
                          articles a, types t, topics top
                          where a.type_id = t.type_id 
                          and a.topic_id = top.topic_id ")

topicname <- dbGetQuery(db," select distinct a.article_id,top.name topicname,t.name typename
                      from 
                      articles a, types t, topics top
                      where a.type_id = t.type_id 
                      and a.topic_id = top.topic_id ")

type <- dbGetQuery(db,"select distinct type_id from types")

topic <- dbGetQuery(db,"select distinct topic_id from topics")

'''

f <- dbGetQuery(db,"select distinct a.article_id,top.name topicname,t.name typename from 
                articles a, types t, topics top
                where a.type_id = t.type_id 
                and a.topic_id = top.topic_id and article_id = 1")

'''
#converting the query output to df
articledetail <- data.frame(article)
topicdetail <- data.frame(topicname)


colnames(tempfile)[2] <- "article_id" #changing the colnames into common names
#merging the two tables from db and log

tottypeartsent <- merge(tempfile,articledetail,by = "article_id")

dim(tottypeartsent)
summary(tottypeartsent)

#ploting the topics and types of article viewed 
head(topicdetail)
typeplot <- merge (tempfile , topicdetail, by = "article_id")

head(typeplot)
#table(typeplot[,4])
barplot(table(typeplot[,6])) #topic plot

table(typeplot[,5])
barplot(table(typeplot[,7])) #type plot

#writing the merged output to csv

write.csv(tottypeartsent, file = "datasetlinks.csv",row.names=FALSE, na="",col.names=TRUE,sep = ",")
                                    
                