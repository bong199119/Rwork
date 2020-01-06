# chap12_1_LinearRegression

######################
# 1. 단순선형회귀분석
######################
# - 독립변수(1) -> 종속변수(1) 미치는 영향분석

setwd("c:/Rwork/data")
product <- read.csv("product.csv")
str(product)

# 1) x,y 변수 선택
x <- product$"제품_적절성" # 독립변수   #한글로된 칼럼명은 쌍따옴표를 붙여주는것이 좋음
y <- product$"제품_만족도" # 종속변수


df <- data.frame(x, y)
df

# 2) 회귀모델 생성
model <- lm(y ~ x, data = df)
model
# Coefficients : 회귀계수(기울기, 절편)
# (Intercept)               x  
# 0.7789(절편)         0.7393(기울기)  

#회귀방정식(y) = 0.7393*x + 0.7789
head(df)
# 첫번째 관측치가 x = 4, y = 3

x = 4; Y = 3
y = 0.7393*x + 0.7789 # 예측치
y

# 오차 = 관측치(정답) - 예측치
err <- Y - y
err # -0.7361
abs(err) # 0.7361
mse = mean(err^2)#평균제곱오차
mse # 0.5418432 # 제곱


names(model) # 12칼럼 제공
# "Coefficients" 계수
# "residuals" : 오차(잔차)
# "fitted.values" : 적합치(예측치)

model$coefficients
model$residuals #
model$fitted.values # 


# 3) 회귀모델 분석
summary(model)

# <회귀모델 분석 순서>
# 1. 검정통계량:  모델의 유의성 검정 (p < 0.05)
# 2. 모델의 설명력 : Adjusted R-squared:  0.5865  
# 3. x변수 유의성 검정 : 영향력 판단 (p < 0.05)

# R-squared = R^2   Adjusted R-squared:  0.5865 
R <- sqrt(0.5865)
R # 0.7658329

# 4) 회귀선 : 회귀방정식에 읳서 구해진 직선(예측치)

# x, y 산점도 
plot(df$x,df$y)
# 회귀선(직선)
abline(model, col="red")


#######################
# 2. 다중선형회귀분석
#######################
# - 독립변수(n) ->종속변수(1) 미치는 영향분석
install.packages("car")
library(car)
Prestige
str(Prestige)

# 102 직업군 대상 : 교육수준, 수입, 여성비율, 평판, 직원수, 유형
# 'data.frame' : 102 obs. of  6 variables:
row.names(Prestige)

# 1) subset
newdata <- Prestige[c(1:4)]
str(newdata)

# 2) 상관분석
cor(newdata)
#            education     income       women   prestige
# education 1.00000000  0.5775802  0.06185286  0.8501769
# income    0.57758023  1.0000000 -0.44105927  0.7149057
# women     0.06185286 -0.4410593  1.00000000 -0.1183342
# prestige  0.85017689  0.7149057 -0.11833419  1.0000000
# 3) 회귀모델
model <- lm(income ~ education + women + prestige, data = newdata)
model # Coefficients : 
# (Intercept)    education      women     prestige  
#     -253.8        177.2       -50.9        141.4  

income <- 12351 # Y(정답)
education <- 13.11 # x1
women <- 11.16 # x2
prestige <- 68.8 # x3

head(newdata)

# 예측치 : 회귀방정식
y_pred <- 177.2* education + -50.9*women + 141.4*prestige + (-253.8)
y_pred # 11229.57


err <- income - y_pred
err # 1121.432

# 4) 회귀모델 분석
summary(model)
# 모델 유의성 : p-value: < 2.2e-16
# Adjusted R-squared:  0.6323 
# x유의성 검정 : 
#            Estimate Std.   Error    t value    Pr(>|t|)    
# (Intercept) -253.850     1086.157    -0.234      0.816    
# education    177.199      187.632     0.944      0.347 (영향 없음)   
# women        -50.896        8.556    -5.948   4.19e-08 ( - 영향)
# prestige     141.435       29.910     4.729   7.58e-06 ( + 영향)


###################
# 3. 변수 선택법
###################
# - 최적 모델을 위한 x변수 선택

newdata2 <- Prestige[c(1:5)]
dim(newdata2) # 102   5

library(MASS)
model2 <- lm(income ~ ., data = newdata2) # .은 income을 제외한 모든데이터

step <- stepAIC(model2, direction = "both")
step

model3 <- lm(formula = income ~ women + prestige, data = newdata2)

summary(model3)
# F-statistic: 87.98 on 2 and 99 DF
#  Adjusted R-squared:  0.6327 
#   women        -48.385      8.128  -5.953 4.02e-08 
#   prestige     165.875     14.988  11.067  < 2e-16



###############
# 4. 기계학습
###############


iris_data <- iris[-5]
str(iris_data)
# 'data.frame':	150 obs. of  4 variables:

# 1) train/test set(70 vs 30)
idx <- sample(x = nrow(iris_data), size=nrow(iris_data)*0.7, 
              replace = FALSE)

idx
train <- iris_data[idx,]
test <- iris_data[-idx,]

dim(train) #  105   4(y+x)
dim(test) #  45  4(y+x)


# 2) model(train)
model <- lm(Sepal.Length~.,data=train)

# 3) 모델 평가(test)
y_pred <- predict(model, test) # y 예측치
y_pred
y_true <- test$Sepal.Length # y 정답
y_true

# 평가 : mse(평균제곱오차), cor(상관계수)
mse <- mean((y_true - y_pred)^2)
mse # 0.09911753

cor(y_true, y_pred) #  0.930735


# y real value vs y prediction
plot(y_true, col="blue", type = "o", pch = 18)
points(y_pred, col="red", type = "o", pch = 18)
title("real value vs prediction")
#범례
legend("topleft", legend = c("real","pred"), col=c("blue","red"), pch - c(18, 19))




##########################################
##  5. 선형회귀분석 잔차검정과 모형진단
##########################################

# 1. 변수 모델링 : y ~ x
# 2. 회귀모델 생성 : 
# 3. 모형의 잔차검정 
#   1) 잔차의 등분산성 검정
#   2) 잔차의 정규성 검정 
#   3) 잔차의 독립성(자기상관) 검정 
# 4. 다중공선성 검사 
# 5. 회귀모델 생성/ 평가 


names(iris)

# 1. 변수 모델링 : y:Sepal.Length <- x:Sepal.Width,Petal.Length,Petal.Width
formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width


# 2. 회귀모델 생성 
model <- lm(formula = formula,  data=iris)
model
names(model)


# 3. 모형의 잔차검정
plot(model)
#Hit <Return> to see next plot: 잔차 vs 적합값 -> 패턴없이 무작위 분포(포물선 분포 좋지않은 적합) 
#Hit <Return> to see next plot: Normal Q-Q -> 정규분포 : 대각선이면 잔차의 정규성 
#Hit <Return> to see next plot: 척도 vs 위치 -> 중심을 기준으로 고루 분포 
#Hit <Return> to see next plot: 잔차 vs 지렛대값 -> 중심을 기준으로 고루 분포 

# (1) 등분산성 검정 
plot(model, which =  1) 
methods('plot') # plot()에서 제공되는 객체 보기 

# (2) 잔차 정규성 검정
attributes(model) # coefficients(계수), residuals(잔차), fitted.values(적합값)
res <- residuals(model) # 잔차 추출 
res <- model$residuals # # 잔차추출
res
shapiro.test(res) # 정규성 검정 - p-value = 0.9349 >= 0.05
# 귀무가설 : 정규성과 차이가 없다.

# 정규성 시각화  
hist(res, freq = F) 
qqnorm(res)

# (3) 잔차의 독립성(자기상관 검정 : Durbin-Watson) 
install.packages('lmtest')
library(lmtest) # 자기상관 진단 패키지 설치 
dwtest(model) # 더빈 왓슨 값
# DW = 2.0604 p-value = 0.6013 >= 0.05

# 4. 다중공선성 검사
# - 독립변수 간의 강한 상관관계로 인해서 발생하는 문제
# - ex) 생년월일, 생일



library(car)
sqrt(vif(model)) > 2 # TRUE 

# 5. 모델 생성/평가 
formula = Sepal.Length ~ Sepal.Width + Petal.Length 
cor(iris[-5])

model <- lm(formula = formula,  data=iris)
summary(model) # 모델 평가






