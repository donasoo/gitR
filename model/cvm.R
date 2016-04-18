require(e1071)
require(kernlab)
require(DMwR)

par(mfrow=c(3,3))

# 使用线性核函数，不能很好的划分数据
model1 <- ksvm(cpi ~ .,data=allpi,kernel='vanilladot',C=0.1, type='eps-svr')
pk1 <- predict(model1, allpi)
plot(pk1 ~allpi$cpi, main='线性核函数')
e1 <- regr.eval(allpi$cpi, pk1, train.y = allpi$cpi);
mtext(e1[5], side = 3)
cat('线性')
print(e1)

# 加大惩罚参数，决策边缘缩窄，使训练误差减小
model2 <- ksvm(cpi~.,data=allpi,kernel='vanilladot', C=100, type='eps-svr')
pk2 <- predict(model2, allpi)
plot(pk2 ~allpi$cpi,  main='线性核函数')
e2 <- regr.eval(allpi$cpi, pk2, train.y = allpi$cpi);
mtext(e2[5], side = 3)
cat('加大惩罚参数')
print(e2)

# 使用高斯核函数，正确的分类
model3 <- ksvm(cpi~.,data=allpi,kernel='rbfdot', type='eps-svr')
pk3 <- predict(model3, allpi)
plot(pk3 ~allpi$cpi, main='高斯核')
e3 <- regr.eval(allpi$cpi, pk3, train.y = allpi$cpi); 
mtext(e3[5], side = 3)
cat('高斯')
print(e3)

# 使用多项式核函数，正确的分类
model4 <- ksvm(cpi~.,data=allpi,kernel='polydot', type='eps-svr')
pk4 <- predict(model4, allpi)
plot(pk4 ~allpi$cpi, main='多项式核')
e4 <- regr.eval(allpi$cpi, pk4, train.y = allpi$cpi);
mtext(e4[5], side = 3)
cat('多项式')
print(e4)

# 使用Hyperbolic核函数，正确的分类
model5 <- ksvm(cpi~.,data=allpi,kernel='tanhdot', type='eps-svr')
pk5 <- predict(model5, allpi)
plot(pk5 ~allpi$cpi, main='Hyperbolic')
e5 <- regr.eval(allpi$cpi, pk5, train.y = allpi$cpi);
mtext(e5[5], side = 3)
cat('Hyperbolic')
print(e5)

# 使用Laplacian核函数，正确的分类
model6 <- ksvm(cpi~.,data=allpi,kernel='laplacedot', type='eps-svr')
pk6 <- predict(model6, allpi)
plot(pk6 ~allpi$cpi, main='Laplacian')
e6 <- regr.eval(allpi$cpi, pk6, train.y = allpi$cpi);
mtext(e6[5], side = 3)
cat('Laplacian')
print(e6)

# 使用Bessel核函数，正确的分类
model7 <- ksvm(cpi~.,data=allpi,kernel='besseldot', type='eps-svr')
pk7 <- predict(model7, allpi)
plot(pk7 ~allpi$cpi, main='Bessel')
e7 <- regr.eval(allpi$cpi, pk7, train.y = allpi$cpi);
mtext(e7[5], side = 3)
cat('Bessel')
print(e7)

# 使用ANOVA RBF 核函数，正确的分类
model8 <- ksvm(cpi~.,data=allpi,kernel='anovadot', type='eps-svr')
pk8 <- predict(model8, allpi)
plot(pk8 ~allpi$cpi, main='ANOVA RBF ')
e8 <- regr.eval(allpi$cpi, pk8, train.y = allpi$cpi);
mtext(e8[5], side = 3)
cat('ANOVA RBF ')
print(e8)

# 使用Spline核函数，正确的分类
model9 <- ksvm(cpi~.,data=allpi,kernel='splinedot', type='eps-svr')
pk9 <- predict(model9, allpi)
plot(pk9 ~allpi$cpi, main='Spline')
e9 <- regr.eval(allpi$cpi, pk9, train.y = allpi$cpi);
mtext(e9[5], side = 3)
cat('Spline')
print(e9)