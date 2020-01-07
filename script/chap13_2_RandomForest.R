# chap13_2_RandomForest
install.packages("randomForest")
library(randomForest)



names(iris) # 랜덤포레스트는 iris 150개의 데이터를 500개로 만들어줌
#############################
# 분류트리(범주형)
############################

# 1. model
model <- randomForest(Species ~., data = iris)
# 500개의 데이터셋을 생성 -> 500tree(model) 생성

model
# Number of trees: 500 -> 트리수
# No. of variables tried at each split: 2 -> 노드 분류 사용에 사용된 개수

# OOB estimate of  error rate: 4.67%
# 분류 정확도 95.33%
# 
# Confusion matrix:
#             setosa  versicolor  virginica  class.error
# setosa         50           0          0         0.00
# versicolor      0          47          3         0.06
# virginica       0           4         46         0.08

(50+47+46) / 150  # 0.9533333


?randomForest
model2 <- randomForest(Species ~., data = iris,
                       ntree=400, mtry = 2,
                       importance = TRUE,
                       na.action = na.omit)
model2 

importance(model2)
# MeanDecreaseGini : 노드 불순도(불확실성) 개선에 기여하는 변수

varImpPlot(model2)


############################
# 회귀트리(y변수 : 연속형)
############################
library(MASS)
data("Boston")

str(Boston)

# y = medv
# x = 13칼럼

p = 14
(1/3) * p

mrty = round((1/3) * p)
mtry = floor((1/3) * p)
mtry

model3 <- randomForest(medv ~., data = Boston,
                       ntree=500, mtry = mtry,
                       importance = TRUE,
                       na.action = na.omit)
model3



# 중요변수 시각화
varImpPlot(model3)










