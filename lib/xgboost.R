xgb<- function(data, K){
  library(data.table)
  library(FeatureHashing)
  library(xgboost)
  library(dplyr)
  library(Matrix)
  Y<- data$outcome
  data$outcome<- NULL
  # nm1 <- names(data)[which(sapply(data, function(x) sum(x==0)>0))]
  # # Results:
  # # [1] "people_char_10" "people_char_11" "people_char_12" "people_char_13" "people_char_14" "people_char_15"
  # # [7] "people_char_16" "people_char_17" "people_char_18" "people_char_19" "people_char_20" "people_char_21"
  # # [13] "people_char_22" "people_char_23" "people_char_24" "people_char_25" "people_char_26" "people_char_27"
  # # [19] "people_char_28" "people_char_29" "people_char_30" "people_char_31" "people_char_32" "people_char_33"
  # # [25] "people_char_34" "people_char_35" "people_char_36" "people_char_37" "people_char_38"
  # snm1<- names(data)[which(sapply(data, function(x) sum(x==0)==0))]
  # # Results:
  # #  [1] "V1"                "people_id"         "activity_id"       "date"              "activity_category"
  # #  [6] "char_1"            "char_2"            "char_3"            "char_4"            "char_5"           
  # # [11] "char_6"            "char_7"            "char_8"            "char_9"            "char_10"          
  # # [16] "people_char_1"     "people_group_1"    "people_char_2"     "people_date"       "people_char_3"    
  # # [21] "people_char_4"     "people_char_5"     "people_char_6"     "people_char_7"     "people_char_8"    
  # # [26] "people_char_9"    
  # snm1<- snm1[-(1:4)]
  # # [1] "activity_category" "char_1"            "char_2"            "char_3"            "char_4"           
  # # [6] "char_5"            "char_6"            "char_7"            "char_8"            "char_9"           
  # # [11] "char_10"           "people_char_1"     "people_group_1"    "people_char_2"     "people_date"      
  # # [16] "people_char_3"     "people_char_4"     "people_char_5"     "people_char_6"     "people_char_7"    
  # # [21] "people_char_8"     "people_char_9"
  # snm1<- snm1[-15]
  # # [1] "activity_category" "char_1"            "char_2"            "char_3"            "char_4"           
  # # [6] "char_5"            "char_6"            "char_7"            "char_8"            "char_9"           
  # # [11] "char_10"           "people_char_1"     "people_group_1"    "people_char_2"     "people_char_3"    
  # # [16] "people_char_4"     "people_char_5"     "people_char_6"     "people_char_7"     "people_char_8"    
  # # [21] "people_char_9"
  
  data$i<- 1:dim(data)[1]
  D<- data
  data.sparse=
    cBind(sparseMatrix(D$i,D$activity_category),
          sparseMatrix(D$i,D$people_group_1),
          sparseMatrix(D$i,D$char_1),
          sparseMatrix(D$i,D$char_2),
          sparseMatrix(D$i,D$char_3),
          sparseMatrix(D$i,D$char_4),
          sparseMatrix(D$i,D$char_5),
          sparseMatrix(D$i,D$char_6),
          sparseMatrix(D$i,D$char_7),
          sparseMatrix(D$i,D$char_8),
          sparseMatrix(D$i,D$char_9),
          sparseMatrix(D$i,D$char_10),
          sparseMatrix(D$i,D$people_char_1),
          sparseMatrix(D$i,D$people_char_2),
          sparseMatrix(D$i,D$people_char_3),
          sparseMatrix(D$i,D$people_char_4),
          sparseMatrix(D$i,D$people_char_5),
          sparseMatrix(D$i,D$people_char_6),
          sparseMatrix(D$i,D$people_char_7),
          sparseMatrix(D$i,D$people_char_8),
          sparseMatrix(D$i,D$people_char_9)
    )
  
  data.sparse=
    cBind(data.sparse,
          D$people_char_10,
          D$people_char_11,
          D$people_char_12,
          D$people_char_13,
          D$people_char_14,
          D$people_char_15,
          D$people_char_16,
          D$people_char_17,
          D$people_char_18,
          D$people_char_19,
          D$people_char_20,
          D$people_char_21,
          D$people_char_22,
          D$people_char_23,
          D$people_char_24,
          D$people_char_25,
          D$people_char_26,
          D$people_char_27,
          D$people_char_28,
          D$people_char_29,
          D$people_char_30,
          D$people_char_31,
          D$people_char_32,
          D$people_char_33,
          D$people_char_34,
          D$people_char_35,
          D$people_char_36,
          D$people_char_37,
          D$people_char_38)
  p <- list(objective = "binary:logistic", 
                    eval_metric = "auc",
                    booster = "gblinear", 
                    eta = 0.02,
                    subsample = 0.7,
                    colsample_bytree = 0.7,
                    min_child_weight = 0,
                    max_depth = 10)
  set.seed(120)
 dtrain1  <- xgb.DMatrix(data.sparse , label = Y)
 xgb.cv(data=dtrain1, nrounds = 100, nfold = 5, params = p)
}