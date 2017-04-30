library(sqldf)
library(data.table)
setwd('E:\\Data Science\\AV\\MiniSolve\\')
test = read.csv("testdata_new1.csv")
train = read.csv("traindata_new1.csv")
user = read.csv("user.csv")
article = read.csv("article.csv")
traindata_new = read.csv("traindata_new.csv")
common = read.csv("common.csv")
head(train)
head(test)
head(article)
colnames(test)
colnames(article)

df3 <- sqldf("SELECT train.User_ID, train.Article_ID, 
                      train.var, train.age, article.VintageMonths,
                      article.NumberOfArticlesBySameAuthor,
                      article.NumberOfArticlesinSameCategory
               FROM train 
              LEFT OUTER JOIN article ON train.Article_ID = article.Article_ID")
             

df4 <- sqldf("SELECT test.User_ID, test.Article_ID, 
                      test.var, test.age, article.VintageMonths,
                      article.NumberOfArticlesBySameAuthor,
                      article.NumberOfArticlesinSameCategory
               FROM test 
              LEFT OUTER JOIN article ON test.Article_ID = article.Article_ID")

df5 <- sqldf("SELECT User_ID, count(Article_ID) as count
                  from common GROUP BY User_ID")

df6 <- sqldf("SELECT User_ID from test where
              User_ID NOT IN (SELECT User_ID from train)")

df7 <-sqldf("SELECT DISTINCT(User_ID) from train")
nrow(df7)
nrow(df6)

nrow(test)
traindata = df3
testdata = df4
head(traindata)
write.csv(traindata, 'traindata_new.csv')
write.csv(testdata, 'testdata_new.csv')