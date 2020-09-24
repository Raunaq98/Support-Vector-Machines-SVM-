# imported data as movies_reg
# we will predict the value of collection


#### EDA
summary(movies_reg)

# NAs
mean_time_reeg<- mean(movies_reg$Time_taken,na.rm = TRUE)
time_clean_reg<- function(x){
         out<-x
         if(is.na(x)){
                  out<- mean_time_reeg
         }else{
                  out<-x
         }
         out
}
movies_reg$Time_taken<- sapply(movies_reg$Time_taken,time_clean_reg)

# Marketing.expense OUTLIERS 
marketing_upper<- quantile(movies_reg$Marketing.expense,0.99)
market_clean_reg<-function(x){
         out<- x
         if(x<marketing_upper){
                  out<- x
         }else{
                  out<- marketing_upper
         }
         out
}
movies_reg$Marketing.expense<- sapply(movies_reg$Marketing.expense,market_clean)

# twitter_hashtags OUTLIERS
twitter_upper <- 2*quantile(movies_reg$Twitter_hastags,0.99)
twitter_clean_reg<-function(x){
         out<- x
         if(x<twitter_upper){
                  out<- x
         }else{
                  out<- twitter_upper
         }
         out
}
movies_reg$Twitter_hastags<- sapply(movies_reg$Twitter_hastags,twitter_clean_reg)


#### DATA SPLIT
library(caTools)
set.seed(0)
sample<- sample.split(movies_reg$Collection,SplitRatio = 0.8)
train_reg <- subset(movies_reg, sample==TRUE)
test_reg <- subset(movies_reg,sample==FALSE)



#### SVM REGRESSION
library(e1071)

svm_linear_reg <- svm(Collection~.,
                      data = train_reg,
                      kernel = "linear",   # can use polynomial and radial as well
                      cost = 0.01,
                      scale = TRUE)
summary(svm_linear_reg)


#### PREDICTIONS
test_reg$linear <- predict(svm_linear_reg,test_reg)
MSE2 <- mean((test_reg$Collection - test_reg$linear)^2)
# [1] 54847371
