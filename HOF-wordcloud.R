#downloaded transcripts of MLB Hall Of Fame inductee speeches from
#shared by HOF reference librarian.
#used PDF2TextPilot (free converter that can manage multiple files)
#to convert to txt files to create wordcloud visual

library(tm)
library(SnowballC)
library(RColorBrewer)
library(ggplot2)
library(wordcloud)
library(biclust) 
library(cluster)
library(igraph)
library(fpc)
library(Rcampdf)


cname <- file.path("TextSpeeches")   
cname   
dir(cname)

docs <- Corpus(DirSource(cname))
docs

class(docs)

class(docs[[1]])

summary(docs)

docs <- Corpus(DirSource(cname))
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/|@|\\|")
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, stemDocument)
docs <- tm_map(docs, removeWords,c("also", "american", "back", "ball", "basebal",
                                   "call", "can", "career", "come", "day", "ever",
                                   "fame", "field", "first", "game", "get", "good",
                                   "got", "great", "hall", "hit",  "home", "just",
                                   "know", "leagu", "like", "lot", "made", "major",
                                   "make", "man", "manag", "mani", "much", "name",
                                   "new", "next", "now", "one", "page", "peopl",
                                   "pitch", "play", "player", "presid", "right",
                                   "run", "said", "say", "see", "team", "thing",
                                   "think", "want", "way", "well", "will", "win",
                                   "year", "york", "s", "alway", "famer", "guy",
                                   "two", "applaus"))
                                   


dark2 <- brewer.pal(6, "Dark2")
wordcloud(docs, scale=c(2,.5), max.words=1000, random.order=FALSE,
          rot.per=0.35, use.r.layout=FALSE, colors=dark2)
