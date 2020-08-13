##Getting Youtube data
library(vosonSML)
##API
apikey='AIzaSyDSiIRzWWXCMMhlaT_4Vab19L6bP_JlEZE'
youtubeAuth <- Authenticate("youtube", apiKey = apikey)


##Collect data usign youtube video ids
video=c('yTHyMNBkbOY')

youdata=Collect(
  youtubeAuth,
  video,
  verbose = FALSE,
  writeToFile = FALSE)

getwd()
setwd('C:/Users/manth/Downloads/Breastcancer_Comments')
str(youdata)
write.csv(youdata,file='Breastcancer_yTHyMNBkbOY.csv',row.names=FALSE)

##Sentiment Analysis

library(syuzhet)

##Read COmments file

indata=read.csv("Breastcancer_yTHyMNBkbOY.csv",header = T)


##We only need comments for sentiment analysis

comments=iconv(indata$Comment,to='utf-8')

##Obtain sentiment scores
s=get_nrc_sentiment(comments)
library(rlang)
head(s)
s$neutral=ifelse(s$negative+s$positive==0,1,0)
comments[[3]]

##Barplot
barplot(100*colSums(s)/sum(s),
        las=2,
        col =rainbow(10),
        ylab="Percentage",
        main="Sentiment Scores for Youtube Comments")
