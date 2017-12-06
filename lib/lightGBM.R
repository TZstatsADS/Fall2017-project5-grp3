
lightGBM<- function(train_num_runique){

  ### WARNING: to use this model, you have to manually install the lightGBM library
  #You can download and install this library using this link https://github.com/Microsoft/LightGBM/tree/master/R-package
  #libraries used
  library(lightgbm)
  library(magrittr)
  library(data.table)
  library(randomForest)
  library(dplyr)
  
  
  #data treatment:
  train_num_runique = train_num_runique[, !names(train_num_runique) %in% c("V1","activity_id")]
  train_num_runique <- train_num_runique[train_num_runique$people_group_1!="group 17304",]
  
  
  ### Run light GBM for Activity_group=1
  
  #pre-processing
  activity1<- train_num_runique[train_num_runique$activity_category==1,]
  activity1 <- activity1[, !names(activity1) %in% c("row.names")]
  activity1=activity1 %>% mutate_if(is.character, as.factor)
  
  data_without_activity1 <- train_num_runique[train_num_runique$activity_category!=1,]
  data_without_activity1 <- data_without_activity1[, !names(data_without_activity1) %in% c("char_1","char_2","char_3","char_4","char_5","char_6","char_7","char_8","char_9","row.names")]
  data_without_activity1=data_without_activity1 %>% mutate_if(is.character, as.factor)
  
  
  activity1.trainingIndex=sample(nrow(activity1), round((nrow(activity1)*0.70)))
  activity1.test=activity1[-activity1.trainingIndex,]
  activity1.train=activity1[activity1.trainingIndex,]
  
  # Data input to LightGBM must be a matrix, without the label
  rules <- lgb.prepare_rules(data = activity1.train)
  data_activity1.train <- as.matrix(rules$data[, !names(activity1) %in% c("outcome")])
  rules_activity1.test <- lgb.prepare_rules(data = activity1.test, rules = rules$rules)$data
  
  data_activity1.test <- as.matrix(rules_activity1.test[, !names(rules_activity1.test) %in% c("outcome")])
  
  
  # Creating the LightGBM dataset with categorical features
  # The categorical features can be passed to lgb.train to not copy and paste a lot
  activity1.dtrain <- lgb.Dataset(data = data_activity1.train,
                                  label = rules$data$outcome)
  activity1.dtest <- lgb.Dataset(data = data_activity1.test,
                                 label = rules_activity1.test$outcome)
  
  # We can now train a model
  
  activity1.start.time <- Sys.time()
  
  model <- lgb.train(list(objective = "binary",
                          metric = "l2",
                          min_data = 1,
                          learning_rate = 0.1,
                          min_data = 0,
                          min_hessian = 1,
                          max_depth = 8,
                          categorical_feature = c(3:16, 18:53)),
                     activity1.dtrain,
                     1500,
                     valids = list(train = activity1.dtrain, valid = activity1.dtest))
  
  activity1.end.time <- Sys.time()
  
  activity1.time.taken <- round(activity1.end.time - activity1.start.time,2)
  activity1.time.taken
  
  ### Run light GBM for Activity_group !=1
  
  #pre-processing
  without_activity1.trainingIndex=sample(nrow(data_without_activity1), round((nrow(data_without_activity1)*0.70)))
  without_activity1.test=data_without_activity1[-without_activity1.trainingIndex,]
  without_activity1.train=data_without_activity1[without_activity1.trainingIndex,]
  
  # Data input to LightGBM must be a matrix, without the label
  rules <- lgb.prepare_rules(data = without_activity1.train)
  data_without_activity1.train <- as.matrix(rules$data[, !names(without_activity1.train) %in% c("outcome")])
  rules_without_activity1.test <- lgb.prepare_rules(data = without_activity1.test, rules = rules$rules)$data
  data_without_activity1.test <- as.matrix(rules_without_activity1.test[, !names(rules_without_activity1.test) %in% c("outcome")])
  
  
  # Creating the LightGBM dataset with categorical features
  # The categorical features can be passed to lgb.train to not copy and paste a lot
  without_activity1.dtrain <- lgb.Dataset(data = data_without_activity1.train,
                                          label = rules$data$outcome)
  without_activity1.dtest <- lgb.Dataset(data = data_without_activity1.test,
                                         label = rules_without_activity1.test$outcome)
  
  # We can now train a model
  
  without_activity1.start.time <- Sys.time()
  
  model <- lgb.train(list(objective = "binary",
                          metric = "l2",
                          min_data = 1,
                          learning_rate = 0.1,
                          min_data = 0,
                          min_hessian = 1,
                          max_depth = 8,
                          categorical_feature = c(3:16, 18:53)),
                     without_activity1.dtrain,
                     1500,
                     valids = list(train = without_activity1.dtrain, valid = without_activity1.dtest))
  
  without_activity1.end.time <- Sys.time()
  
  without_activity1.time.taken <- round(without_activity1.end.time - without_activity1.start.time,2)
  without_activity1.time.taken
  return(activity1.time.taken, without_activity1.time.taken)
}