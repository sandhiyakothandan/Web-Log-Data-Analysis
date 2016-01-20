datasetlinks.csv
#importing the modified data 
links <- read.table("datasetlinks.csv",sep = ",",header=TRUE)
dim(links)
head(links)

#creating response and predictor variable 
responseY <- (links)[3]
head(responseY)
dim(responseY)
#predictorX <- links[,2:(dim(links)[2])]
predictorX <- data.frame(links$article_id,links$topic_id,links$type_id)

head(predictorX)

#doing PCA to facilitate clusturing 
pca <- princomp(predictorX, cor=T)

pc.comp <- pca$scores
pc.comp1 <- -1*pc.comp[,1] # principal component 1 scores (negated for convenience)
pc.comp2 <- -1*pc.comp[,2] # principal component 2 scores (negated for convenience)


X <- cbind(pc.comp1, pc.comp2)

#ploting the clustered ,model
cl <- kmeans(X,13,iter.max = 10)
cl$cluster
plot(pc.comp1, pc.comp2,col=cl$cluster)
points(cl$centers, pch=16)
