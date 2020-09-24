# imported data as movies_class
# we will predict Start_Tech_Oscar 's class

#### EDA
summary(movies_class)

# 12 NAs in time_taken
# Marketing.expense has some upper outliers
# twitter hashtags has 2 clear outliers

# NAs
mean_time<- mean(movies_class$Time_taken,na.rm = TRUE)
time_clean<- function(x){
         out<-x
         if(is.na(x)){
                  out<- mean_time
         }else{
                  out<-x
         }
         out
}
movies_class$Time_taken<- sapply(movies_class$Time_taken,time_clean)

# Marketing.expense OUTLIERS 
marketing_upper<- quantile(movies_class$Marketing.expense,0.99)
market_clean<-function(x){
         out<- x
         if(x<marketing_upper){
                  out<- x
         }else{
                  out<- marketing_upper
         }
         out
}
movies_class$Marketing.expense<- sapply(movies_class$Marketing.expense,market_clean)

# twitter_hashtags OUTLIERS
twitter_upper <- 2*quantile(movies_class$Twitter_hastags,0.99)
twitter_clean<-function(x){
         out<- x
         if(x<twitter_upper){
                  out<- x
         }else{
                  out<- twitter_upper
         }
         out
}
movies_class$Twitter_hastags<- sapply(movies_class$Twitter_hastags,twitter_clean)

#### DATA SPLIT
library(caTools)
set.seed(0)
sample<- sample.split(movies_class$Start_Tech_Oscar,SplitRatio = 0.8)
train_class <- subset(movies_class, sample==TRUE)
test_class <- subset(movies_class,sample==FALSE)


#### FACTORS REQUIRED FOR SVM CLASSSIFICATION
train_class$Start_Tech_Oscar <- as.factor(train_class$Start_Tech_Oscar)
test_class$Start_Tech_Oscar <- as.factor(test_class$Start_Tech_Oscar)
# if we had left them numeric, svm wouldve done regression


######################## SVM WITH LINEAR KERNEL ################################
library(e1071)

svm_linear <- svm(Start_Tech_Oscar~.,
                  data = train_class,
                  kernel = "linear",
                  cost = 1,               # controls the width of the margin
                  scale = TRUE)           # scales all the variables to get mean=0 and sd=1
summary(svm_linear)

#### PREDICTIONS

linear_pred <- predict(svm_linear,test_class)
table(linear_pred,test_class$Start_Tech_Oscar)
#linear_pred  0  1
#          0 27 21
#          1 19 34
# accuracy = 0.6039604

#### HYPERPARAMETER TUNING

linear_tuned <- tune(svm,
                     Start_Tech_Oscar~.,
                     data = train_class,
                     kernel = "linear",
                     ranges = list(cost = c(0.01,0.1,1,10,100)))

linear_tuned_best <- linear_tuned$best.model                     
summary(linear_tuned_best)       

linear_best_pred <- predict(linear_tuned_best,test_class)
table(linear_best_pred,test_class$Start_Tech_Oscar)
# linear_best_pred  0  1
#                0 27 21
#                1 19 34
# accuracy = 0.6039604
# conincidentaly, cost =1 is still the best value


######################## SVM WITH POLYNOMIAL KERNEL ############################

svm_polynomial <- svm(Start_Tech_Oscar~.,
                      data = train_class,
                      kernel = "polynomial",
                      cost = 1,              
                      degree = 2)

poly_pred <- predict(svm_polynomial,test_class)
table(poly_pred,test_class$Start_Tech_Oscar)
#poly_pred  0  1
#        0 27 17
#        1 19 38
# accuracy = 0.6435644

#### HYPERPARAMETER TUNING

poly_tuned <- tune(svm,
                   Start_Tech_Oscar~.,
                   data = train_class,
                   cross = 4,               # cross validation parameter
                   kernel = "polynomial",
                   ranges = list(cost = c(0.01,0.1,1,10,25,50,75,100), degree = c(0.5,0.75,1,1.25,1.5,1.75,2,3,5)))

poly_tuned_best <- poly_tuned$best.model

poly_best_pred <- predict(poly_tuned_best,test_class)
table(poly_best_pred,test_class$Start_Tech_Oscar)


########################## SVM WITH RADIAL KERNEL ##############################

svm_radial <- svm(Start_Tech_Oscar~.,
                      data = train_class,
                      kernel = "radial",
                      cost = 1,              
                      gamma = 1)

radial_pred <- predict(svm_radial,test_class)
table(radial_pred,test_class$Start_Tech_Oscar)
# radial_pred  0  1
#           0  1  0
#           1 45 55

#### HYPERPARAMETER TUNING

radial_tuned <- tune( svm,
                      Start_Tech_Oscar~.,
                      data = train_class,
                      kernel = "radial",
                      ranges = list(cost = c(0.01,0.1,1,10,25,50,75,100,1000), gamma = c(0.01,0.1,1,2,3,4,5,10,20,50,100)))

radial_tuned_best <- radial_tuned$best.model

radial_best_pred <- predict(radial_tuned_best,test_class)
table(radial_best_pred,test_class$Start_Tech_Oscar)
# radial_best_pred  0  1
#                0 16 13
#                1 30 42
# accuracy = 0.5742574


#### POLYNOMIAL AND RADIAL DO NOT PERFORM MUCH BETTER THAN LINEAR KERNAL BECAUSE THE DATA
# HAS A LINEAR RELATIONSHIP
