# chap13_1_DecisionTree

# 관련 패키지 설치
install.packages("rpart")
library(rpart)

# tree 시각화 패키지
install.packages("rpart.plot")
library(rpart.plot)

# 1. dataset(train/test) : iris
idx <- sample(nrow(iris), nrow(iris)*0.7)
train <- iris[idx, ]
test <- iris[-idx, ]
names(iris)

# 2. 분류모델
model <- rpart(Species ~ ., data = train)
model

# 1) root 105 65 virginica (0.32380952 0.29523810 0.38095238)  루트 -> 시작노드
# 2) Petal.Length< 2.6 34  0 setosa (1.00000000 0.00000000 0.00000000) * -> 별표는 자식이없는 노드를 뜻
# 3) Petal.Length>=2.6 71 31 virginica (0.00000000 0.43661972 0.56338028)  
# 6) Petal.Length< 4.85 31  2 versicolor (0.00000000 0.93548387 0.06451613) *
# 7) Petal.Length>=4.85 40  2 virginica (0.00000000 0.05000000 0.95000000) *

# 분류모델 시각화

rpart.plot(model)
# [중요변수] 가장 중요변수 : "Petal.Length" 


# 3. 모델 평가
y_pred <- predict(model, test) # 비율 예측치
y_pred

y_pred <- predict(model, test, type = "class")
y_pred

y_true <- test$Species

# 교차분할표(confusion matrix)
table(y_true, y_pred)

acc <- (9+20+12) / nrow(test)
acc # 0.9111111


####################
# Titanic 분류분석
####################
titanic3 <- read.csv("titanic3.csv")
str(titanic3)


# int -> Factor(범주형)
titanic3$survived <- factor(titanic3$survived, levels = c(0,1))
table(titanic3$survived)
# 
#    0   1 
# 809 500

809/1305 #  0.6199234 사망비율

# subset 생성 : 칼럼 제외
titanic <- titanic3[-c(3, 8, 10, 12:14)]
str(titanic)
# data.frame':	1309 obs. of  8 variables:
# $ servived : Factor(w / 2)

# train / test set
idx <- sample(nrow(titanic), nrow(titanic)*0.8)
train <- titanic[idx, ]
test <- titanic[-idx, ]

model <- rpart(survived ~ ., data=train)

#model 시각화화
rpart.plot(model)

y_pred <- predict(model, test, type = "class")
y_true <- test$survived

table(y_true, y_pred)
# 
#          y_pred
# y_true    0   1
#     0   146  15
#     1    35  66

acc <- (149+68) / nrow(test)
acc # 0.8282443


table(test$survived)
#   0   1 
# 161 101 


# 제현율(민감도) : yes -> yes
recall <- 66/(35+66)  #  0.6534653
# 정확률
precision <- 66/(15 + 66) #  0.8148148 
# f1 score = ?
f1_score = 2*((precision * recall)/(precision + recall))
f1_score #  0.7252747


























