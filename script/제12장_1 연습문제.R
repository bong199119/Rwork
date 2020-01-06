#################################
## <제12장 연습문제>
################################# 

# 01. mpg의 엔진크기(displ)가 고속도록주행마일(hwy)에 어떤 영향을 미치는가?    
# <조건1> 단순선형회귀모델 생성 

library(ggplot2)
data(mpg)
mpg
summary(mpg)
d <- mpg$displ
h <- mpg$hwy
d
h

df <- data.frame(d,h)
df
model <-  lm(h ~ d, data=df)
model



# <조건2> 회귀선 시각화 

plot(df$d, df$h)
text(df$d, df$h, labels=df$d,
     cex=0.5, pos=3, col="blue")
# pos=c(1:3) ; 1 왼쪽 2 아래 3 위 -> text의 포지션
abline(model, col="red")


# <조건3> 회귀분석 결과 해석 : 모델 유의성검정, 설명력, x변수 유의성 검정  

summary(model)
# 1, F검정통계량 :
# 설명력 :Adjusted R-squared:  0.585 
# 3. x의 유의성 검정 : t=-18.15  p <2e-16




# 02. product 데이터셋을 이용하여 다음과 같은 단계로 다중회귀분석을 수행하시오.
setwd("c:/Rwork/data")
product <- read.csv("product.csv", header=TRUE)
product
nrow(product)
#  단계1 : 학습데이터(train),검정데이터(test)를 7 : 3 비율로 샘플링
idx <- sample(x = nrow(product), size = nrow(product)*0.7, replace = FALSE)
idx

train <- product[idx,]
test <- product[-idx,]


nrow(train)
dim(train)
nrow(test)
dim(test)

#  단계2 : 학습데이터 이용 회귀모델 생성 
#           변수 모델링) y변수 : 제품_만족도, x변수 : 제품_적절성, 제품_친밀도
model <- lm(train$제품_만족도 ~ ., data = train)
model

#  단계3 : 검정데이터 이용 모델 예측치 생성 
y_pred <- predict(model,test)
?predict


y_pred
y_true <- test$제품_만족도
y_true



#  단계4 : 모델 평가 : cor()함수 이용  
cor(y_pred, y_true)
# 0.7501125






# 03. ggplot2패키지에서 제공하는 diamonds 데이터 셋을 대상으로 
# carat, table, depth 변수 중 다이아몬드의 가격(price)에 영향을 
# 미치는 관계를 다중회귀 분석을 이용하여 예측하시오.
#조건1) 다이아몬드 가격 결정에 가장 큰 영향을 미치는 변수는?
#조건2) 다중회귀 분석 결과를 정(+)과 부(-) 관계로 해설

library(ggplot2)
data(diamonds)

