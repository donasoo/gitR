require(kernlab);
require(DMwR);
require(reshape2);
require(ggplot2);
require(car);
require(scales);
require(mboost);
require(nnet);
require(pls);
require(randomForest);
require(ipred);

mmodel <- function(train, test, name, mname, parameter=0){
 
  
  if(mname == 'svm'){
   set.seed(3721)
	model <- ksvm(cpi~., data=train, kernel='anovadot', type='eps-svr', epsilon=0.03, C=5);
  }else if(mname == 'rf'){
  set.seed(3721)
	model <- randomForest(cpi ~ ., data =train, mtry=50, ntree=200);
  }else if(mname == 'bagging'){
  set.seed(3721)
	model <- bagging(cpi ~ ., data =train, nbagg = 200);
  }else if(mname == 'boost'){
  set.seed(3721)
	model <- mboost(cpi ~ ., data =train);
  }else if(mname == 'plsr'){
  set.seed(3721)
	model <- plsr(cpi ~ ., data =train, ncomp=5, validation = "LOO");
  }
  
  predt <- predict(model,  newdata=test);

  if(mname == 'plsr'){
    plsrplot(test, predt, name, mname, model);
  }else{
    mplot(test, predt, name, mname);
  }
  
  
  # 保存误差
  error <- regr.eval(test$cpi, predt, train.y = train$cpi);
  
  cat('误差\n')
  print(error)
  
  out <- list('error'=error, 'predict'=predt, 'model'=model)
  return (out);
}

