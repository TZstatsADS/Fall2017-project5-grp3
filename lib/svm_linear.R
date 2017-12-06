svm_linear<- function(data,K){
  library("e1071")
  library("dplyr")
  library("data.table")
  
  cv_acu<-c()
  train_time <- c()
  t<- data[ ,-c(1:4,20)]
  t<- t[1:30000, ]
  n <- length(t$outcome)
  n.fold <- floor(n/K)
  s <- sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))
  Y<- t$outcome
  t$outcome<- NULL
  for (i in 1:K){
    train.data <- t[s!= i, ]
    train.label <- Y[s != i]
    test.data <- t[s == i, ]
    test.label <- Y[s == i ]
    time = proc.time()
    model <- svm(x= train.data, y=train.label, kernel = 'linear' )
    print(model)
    pred <- predict(model, test.data )
    cv_acu[i]<- sum(test.label == round(pred) )/ length(test.label)
    train_time[i] = (proc.time() - time)[3]
    
  }		
  return(list(mean(cv_acu),
              mean(train_time)))
  
}
