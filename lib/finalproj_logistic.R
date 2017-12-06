#######################################
#READ IN DATA + DIVIDE INTO TRAIN/TEST
#######################################
set.seed(4)

setwd("~/Project 5")

data <- read.csv("train_num.csv")

#subset to relevant variables
#unfortunately, multinom() cannot handle more than 1024 categories of a variable
data <- subset(data,select=-c(X,people_id,activity_id,date,people_date))

#split into train and test
index <- sample(1:nrow(data2), size=0.7*nrow(data2))
train_data <- data2[index,]
test_data <- data2[-index,]


#####################
#LOGISTIC REGRESSION
#####################
library(nnet)
library(caret)

multinom_train <- function(train_data){
  multinom_fit <- multinom(formula = as.factor(outcome) ~ .,
                           data=train_data, MaxNWts = 10000, maxit = 500)
  top_models = varImp(multinom_fit)
  top_models$variables = row.names(top_models)
  top_models = top_models[order(-top_models$Overall),]
  return(list(fit=multinom_fit, top=top_models))
}

# run it:
multinomfit_train = multinom_train(train_data)
system.time(multinom_train(train_data))


#######################################
# multinom_test function
#######################################
multinom_test <- function(test_data, fit){
  multinom_pred = predict(fit,newdata=test_data)
  return(multinom_pred)
}

# run it:
multinomtest_result = multinom_test(test_data,multinomfit_train$fit)
postResample(test_data$outcome,multinomtest_result)
system.time(multinom_test(test_data3,multinomfit_train$fit))


#> postResample(test_data$outcome,multinomtest_result)
#with the following parameters: MaxNWts = 10000, maxit = 500
#Accuracy     Kappa 
#0.8335426 0.6708800 



