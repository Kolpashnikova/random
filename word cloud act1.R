library(tm)
library(wordcloud)
library(memoise)

men<-readLines("Men.txt", encoding = "UTF-8")
women<-readLines("Women.txt", encoding = "UTF-8")

  myCorpus <- Corpus(VectorSource(women))
  myCorpus <- tm_map(myCorpus, content_transformer(tolower))
  myCorpus <- tm_map(myCorpus, removePunctuation)
  myCorpus <- tm_map(myCorpus, removeNumbers)
  myCorpus <- tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "women", "girls", "men", "to", "and", "but", "skills", "â???""))
  
  myDTM <- TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m <- as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)

  
 wordcloud(myCorpus, scale=c(3,.2), min.freq=1, max.words=100, random.order=TRUE,
           rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Dark2"))
