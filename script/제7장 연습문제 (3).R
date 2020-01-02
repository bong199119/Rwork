#################################
## <제7장 연습문제>
################################# 

# 01. 본문에서 생성된 dataset2의 resident 칼럼을 대상으로 NA 값을 제거하시오.(힌트 : subset()함수 이용)
str(dataset2)
dataset2$resident <- ifelse(is.na(dataset2$resident), 0, dataset2$resident)
dataset2

# 02. dataset2의 gender 칼럼을 대상으로 1->"남자", 2->"여자" 형태로 코딩 변경하여 
# gender2 칼럼에 추가하고, 파이 차트로 결과를 확인하시오.
head(dataset2)
summary(dataset2)
plot(dataset2$gender)
dataset2$gender2 <- ifelse(dataset2$gender==1, "남자","여자")
dataset2
pie(table(dataset2$gender2))

# 03. 나이를 30세 이하 -> 1, 31~55 -> 2, 56이상 -> 3 으로 코딩변경하여 age2 칼럼에 추가한 후 
# age, age2 칼럼만 확인하시오.
age3 <- 0
for(i in 1:nrow(dataset2)){
  if(dataset2$age[i] <= 30){
    age3[i] <- 1
  }else if(dataset2$age[i] >=56){
    age3[i] <- 3
  }else{
    age3[i] <- 2
  }
}
dataset2$age3 <- age3  
dataset2[c("age","age3")]


# 04. ggplot2 패키지에서 제공하는 mpg 데이터셋의 hwy 변수를 대상으로 이상치를 발견하고, 제거하시오.
install.packages("ggplot2")
library(ggplot2)
mpg <- as.data.frame(mpg)
mpg
str(mpg)
head(mpg)
summary(mpg$hwy)



# 단계1) 상자그래프와 통계량 
boxplot(mpg$hwy)$stats

# 단계2) 이상치 제거 
mpg2 <- subset(mpg, hwy>=30|hwy<=15)
boxplot(mpg2$hwy, range=0)
summary(mpg2$hwy)

# 05. iris 데이터셋을 대상으로 8:2비율로 sampling하여 train과 test 셋을 만드시오.
dim(iris)

nrow(iris)

idx <- sample(x = nrow(iris), size = nrow(iris)*0.8)
idx

train <- iris[idx, ]
test <- iris[-idx, ]
dim(train)
dim(test)


#########################
# train/test model 적용
#########################

# 50% vs 50%
idx <- sample(nrow(iris), nrow(iris)*0.5)

train <- iris[idx, ]
test <- iris[-idx, ]

dim(train)
dim(test)

head(iris)
# Sepal.Length : y(종속변수) -> 정답
# Petal.Length : x(독립변수) -> 입력
# model : 꽃잎 길이 -> 꽃받침 길이


# train dataset model
model <- lm(Sepal.Length ~ Petal.Length, data = train )
model
pred <- model$fitted.values # 예측치(꽃받침 길이)
pred

# test ataset model
model2 <- lm(Sepal.Length ~ Petal.Length, data= test)
pred2 <- model2$fitted.values #

# train_y
train_x <- train$Petal.Length # train 정답

# test_y
test_x <- test$Petal.Length # test 정답
test_y <- test$Sepal.Length 

# 정답 vs 예측치
plot(train_x, pred, col="blue", pch=18) # plot(x,y)
points(test_x, pred2, col="red",pch=19) # 

# 예측치 vs 정답(참고용)
plot(train_x, pred, col="blue", pch=18) # plot(x,y)
points(test_x, test_y, col="red",pch=19) # 

# 범례
legend("topleft", legend = c("train", "test"),
       col = c("blue", "red"), pch = c(18,19))







