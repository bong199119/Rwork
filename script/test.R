########################################################################################################
# 
# chap02_DataStructure
# - Vector, Matrix, Data.frame 자료 구조 특징 
# 
# 
# 1. vector : 동일 데이터 타입을 갖는 1차원 배열
# 접근 : [index] : 1부터 시작
# 동일한 타입의 데이터만 저장 가능
# 벡터 데이터 생성 함수 : c(), seq(), rep()
# 
# 2. matrix : 동일 데이터 타입을 갖는 2차원 배열
# 동일 데이터 타입을 갖는 2차원 배열
# Matrix 데이터 생성 함수
# rbind() : 행묶음
# cbind() : 컬럼 묶음
# Matrix 데이터 처리 함수
# apply() : 함수적용
# 
# 
# 3. data.frame : 열 단위로 서로 다른 데이터 타입을 갖는 배열
# -> 2차원 테이블 구조(DB 테이블과 유사)
# list와 Vector 혼합형
# - 컬럼 구성 : list, list 구성 : vector
# 컬럼 단위로 서로 다른 자료형 가능
# 
# 
# 4. Array : 동일 데이터 타입을 갖는 다차원 배열
# 5. List : 서로 다른 데이터 구조(Vector, Data Frame, Array, List) 중첩


########################################################################################################
#index

x1 <- 1:5 #c(1:5)
x2 <- 2:6
x1; x2
# rbind()
m2 <-rbind(x1, x2)
m2
dim(m2)

# cbind()

m3 <- cbind(x1,x2)
m3


#matrix index
m3[1, 2]
m3[1,]
m3[,2]

#box
m2 [c(1:2),c(2:4)]


########################################################################################################
# apply

x <- 1:10
x*0.5 # vector*scala

# 2) vector vs matrix
x <- 1:3
x
y <- matrix(1:6, nrow = 2)

dim(y)
y

z<- x*y
z


# apply() : 처리  행간 혹은 열간 합
apply(z, 1, sum)
apply(z, 2, sum)
apply(z, 2, mean)
apply(z, 2, max) #4 9 18

########################################################################################################
#subset
setwd("c:/rwork/data/")
dataset <- read.csv("dataset.csv")
str(dataset)
dataset2 <- subset(dataset, !is.na(price)) # (dataset, 조건식)
dataset2

########################################################################################################
# 1. 사용자 정의 함수

# 함수명 <- function(인수){
#   명령문1
#   명령문2
#   return(값)
# }

# 1) 매개변수가 없는 함수
user_fun1 <- function(){
  cat("user_fun1")
}

# 함수 호출
user_fun1()

# 2) 매개변수가 있는 함수
user_fun2 <- function(x,y){
  z <- x+y
  cat('z=', z)
}

user_fun2(10, 20)


# 3) 반환값이 있는 함수
user_fun3 <- function(x,y){
  z <- x+y
  #cat('z=',z)
  return(z) # 반환값
}

z = user_fun3(100,200)
z
z2 <- z^2
cat('z^2=',z2)


# 문) 다음과 같은 함수를 만드시오.
# 조건1 > 함수명 : calc
# 조건2 > 인수 2개 : x,y
# 조건3 > 처리문 : 사칙연산(+,-,*,/) 출력


calc <- function(x,y){
  add<- x+y
  sub<- x-y
  div<- x*y
  mul<- x/y
  print(add)
  print(sub)
  print(div)
  print(mul)
  #return (add, sub, div, mul)
  #다중인자 반환은 허용되지 않습니다.
  calc_re <- data.frame(add,sub,div,mul)
  return(calc_re)  
}


# 함수 호출
result <- calc(100,50)
class(result)
result



# ex1) 결측치 자료 처리 함수
na <- function(data){
  # 1차 : NA 제거
  print(data)
  print(mean(data,na.rm=T))
  
  
  # 2차 : NA -> 0대체
  tmp <- ifelse(is.na(data),0,data)
  print(tmp)
  print(mean(tmp))
  
  
  # 3차 : NA -> 평균 대체
  tmp <- ifelse(is.na(data), mean(data, na.rm=T), data)
  print(tmp)
  print(mean(tmp))
  
}

data <- c(10,2,4,5,NA,1,NA,14)
data

# 함수 호출
na(data)



# ex2) 특수문자 처리 함수

install.packages("stringr")
library(stringr)

library(help="stringr")

string <- "홍길동35이순신46유관순25"
name <- str_extract(string,"[가-힣]{3}")
name

names <-  str_extract_all(string,"[가-힣]{3}")
names #list
#[[1]] -> key
# [1] "홍길동" "이순신" "유관순" ->value
names <- unlist(names) #list -> vector
names #[1] "홍길동" "이순신" "유관순"

string2 <- " $(125,457)%"
string*2 # 에러

# 1. 특수문자 제거
tmp <- str_replace_all(string2, "\\$|\\(|\\,|\\)|\\%","" )
tmp

# 2. 문자열 -> 숫자형 변환
num <- as.numeric(tmp)
num*2

#특수문자 처리 함수 정의
data_pro <- function(data){
  library(stringr) # in memory
  
  # 1. 특수문자 제거
  tmp <- str_replace_all(data, "\\$|\\(|\\,|\\)|\\%","" )
  tmp
  
  # 2. 문자열 -> 숫자형 변환
  num <- as.numeric(tmp)
  num*2
  
  return(num)
}

# dataset
setwd("c:/rwork/data")
stock <- read.csv("stock.csv")
stock
str(stock)


#subset : 1~15
stock_df <- stock[c(1:15)]
str(stock_df)
head(stock_df)


#숫자(7~15) : 특수문자 제거, NA -> 0 
stock_num <- apply(stock_df[c(7:15)], 2, data_pro)
stock_num

#df = 문자열 칼럼 + 숫자칼럼
new_stock <- cbind(stock_df[c(1:6)], stock_num)
head(new_stock)

########################################################################################################


# 1. 이산변수(discrete quantitative data) 시각화
# - 정수단위로 나누어 측정할 수 있는 변수(자녀수, 판매수)



# 차트 데이터 생성
chart_data <- c(305,450, 320, 460, 330, 480, 380, 520)
names(chart_data) <- c("2014 1분기","2015 1분기","2014 2분기","2015
2분기","2014 3분기","2015 3분기","2014 4분기","2015 4분기")
str(chart_data)
chart_data

# 1) 막대차트 시각화
barplot(chart_data, ylim = c(0, 700),
        col= rainbow(8), 
        main = "2016년도 vs 2017년도 분기별 매출현황")

?barplot


# 가로막대차트
barplot(chart_data, xlim = c(0, 700),
        col= rainbow(8), horiz = TRUE, 
        main = "2016년도 vs 2017년도 분기별 매출현황")


# 1행2열 구조

par(mfrow=c(1,2)) # 1행 2열 그래프 보기

# 개별 막대차트
barplot(VADeaths, beside=T,col=rainbow(5),
        main="미국 버지니아주 하위계층 사망비율")

# 누적형 막대차트
barplot(VADeaths, beside=F,col=rainbow(5),
        main="미국 버지니아주 하위계층 사망비율")


# 2) 점 차트 시각화

par(mfrow=c(1,1))
dotchart(chart_data, color = c("purple", "red"),
         labels = names(chart_data), xlab = "매출액",
         main = "분기별 판매현황")

# 3) 파이 차트 시각화
pie(chart_data, labels =  names(chart_data),
    col=rainbow(8), cex = 1.3)
title("2015 vs 2017 판매현황")


# 2. 연속변수 (Continuous quantitative)
# - 시간, 길이 등과 같이 연속성을 가진 실수 단위 변수값

# 1) 상자 그래프 시각화 
VADeaths
str(VADeaths)
# num [1:5, 1:4]  ->  matrix
summary(VADeaths)

boxplot(VADeaths, range = 0)

# 2) 히스토그램 시각화 : 대칭성 확인
iris
head(iris)

range(iris$Sepal.Length)
hist(iris$Sepal.Length, xlab = "sepal.length",
     col = "magenta",
     main = "iris 꽃받침 길이", xlim = c(4.3,7.9))

range(iris$Sepal.Width)
hist(iris$Sepal.Width,
     xlab = "Sepal.Width",
     col = " green",
     main = " iris 꽃받침 넓이",
     xlim = c(2.0, 4.4))


# 정규분포 가설 : 정규분포와 차이가 없다.
# 정규성 검정
shapiro.test(iris$Sepal.Length) # p-value = 0.01018 < 알파 = 0.05 : x -> 기각
shapiro.test(iris$Sepal.Width) # p-value = 0.1012 > 알파 = 0.05 : o -> 채택

# 3) 산점도 시각화
price <- runif(10, min =1, max =100)
price

plot(price) # 하나만 넣으면 y에 들어감, x축에는 index


par(mfrow=c(2,2))

plot(price, type="o") # circle
plot(price, type="l") # line
plot(price, type="h") # height
plot(price, type="s") # step


# plot -> 만능 차트 

par(mfrow=c(1,1))
data()


AirPassengers
plot(AirPassengers)

plot(WWWusage)


# 회귀 모델 -> 회귀모델 시각화

install.packages("HistData")
library(HistData)

library(help="HistData")

data(Galton)
str(Galton)
# 'data.frame':	928 obs. of  2 variables:
# $ parent
# $ child

model <- lm(child ~ parent, data = Galton)#lm(y~x)
model # Coefficients:

# 회귀모델 관련 시각화
plot(model)

methods(plot)


# 3. 변수간의 비교 시각화
?pairs()
pairs(iris[1:4])

#꽃의 종별 변수 비교
unique(iris$Species)
# setosa  versicolor  virginica

pairs(iris[iris$Species == 'setosa',1:4])
pairs(iris[iris$Species == 'versicolor',1:4])
pairs(iris[iris$Species == 'virginica',1:4])


########################################################################################################


# chap07_EDA_Preprocessing

# 실습 데이터 파일 가져오기
setwd("c:/rwork/data/")
dataset <- read.csv("dataset.csv")
str(dataset)


# 'data.frame':	300 obs. of  7 variables:
#   $ resident: int  1 2 NA 4 5 3 2 5 NA 2 ...
# $ gender  : int  1 1 1 2 1 1 2 1 1 1 ...
# $ job     : int  1 2 2 NA 3 2 1 2 1 2 ...
# $ age(비율)     : int  26 54 41 45 62 57 36 NA 56 37 ...
# $ position: int  2 5 4 4 5 NA 3 3 5 3 ...
# $ price(비율)   : num  5.1 4.2 4.7 3.5 5 5.4 4.1 675 4.4 4.9 ...
# $ survey(등간)  : int  1 2 4 2 1 2 4 4 3 3 ...

# 1. 결측치(NA) 처리

# 1) 결측치 확인
summary(dataset) # 콘솔보면 맨 아랫단에 NA's라고 있음

# 2) 칼럼 기준 결측치 제거 : subset()
dataset2 <- subset(dataset, !is.na(price)) # (dataset, 조건식)
dim(dataset2) # 270
head(dataset2)

# 3) 전체 칼럼 기준 결측치 제거 : na.omit()
dataset2 <- na.omit(dataset)
dim(dataset2)
head(dataset2)

# 4) 결측치 처리(0으로 대체)
dataset$price2 <- ifelse(is.na(dataset$price), 0, dataset$price)
head(dataset, 30)
dataset[c("price","price2")]

# 5) 결측치 처리(평균으로 대체)
avg <- mean(dataset$price, na.rm = T)
avg
dataset$price3 <- ifelse(is.na(dataset$price), avg,dataset$price)
dataset[c("price","price2","price3")]

# 6) 통계적 방법 : 고객 유형별 NA 처리
# type : 1. 우수고객, 2. 보통고객, 3. 저조고객
# 1. 우수 : 8.75*1.5
# 2. 보통 : 8.75
# 3. 저조 : 8.75*0.5
dim(dataset) # 300 9
type <- rep(1:3, 100)
type
# 칼럼 추가
dataset$type <- type
head(dataset)


price4 <- 0 # 통계적 방법
for(i in 1:nrow(dataset)){ # index : 300 반복
  if(is.na(dataset$price[i])){
    if(dataset$type[i] == 1 ){
      price4[i] = avg*1.5
    }else if(dataset$type[i] == 2){
      price4[i] = avg
    }else{
      price4[i] = avg*0.5
    }
  }else{ # NOT NA
    price4[i] <- dataset$price[i]
  }
}

length(price4)

# 칼럼 추가
dataset$price4 <- price4
dataset[c("price","price2","price3","price4")]

dataset



# 2. 이상치(극단치) 발견과 정제
# - 정상 범주에서 크게 벗어난 값
# - 분서결과를 왜곡 시킴

# (1) 범주형(명목, 서열) 극단치 처리
gender <- dataset$gender
gender

# 빈도수 확인
table(gender)

# 0   1   2   5  -> 범주 # 1하고 2만 있어야 하는데 0, 5가 있음 -> 잘못된 데이터
# 2 173 124   1  -> 빈도

pie(table(gender))

# 이상치 정제
dataset <- subset(dataset, gender == 1 | gender == 2)

pie(table(dataset$gender))

# 2) 비율척도 이상치 처리
price <- dataset$price # 구매금액
plot(price)

# 이상치 발견
boxplot(price)$stats # $ stats -> 수치제공

# 이상치 정제
dataset2 <- subset(dataset, price >=2.1 & price <= 7.9)
plot(dataset2$price)

# age 변수 이상치 처리
summary(dataset2$age) # 16
dataset2 <- subset(dataset2, age >= 20 & age <= 69)
plot(dataset2$age)


# 3. 코딩 변경 : 최초 코딩 내용을 변경
# - 데이터 가독성, 척도 변경

# 1) 데이터 가독성
table(dataset2$resident)
# 0   1   2   3   4   5 
# 15 102  46  22  13  34

dataset2$resident2[dataset2$resident ==1] <- "1.서울시"
dataset2$resident2[dataset2$resident ==2] <- "1.인천시"
dataset2$resident2[dataset2$resident ==3] <- "1.대전시"
dataset2$resident2[dataset2$resident ==4] <- "1.대구시"
dataset2$resident2[dataset2$resident ==5] <- "1.부산시"


# 2) 척도변경(연속형 -> 범주형)
dataset2$age2[dataset2$age <= 30] <- "청년층"
dataset2$age2[dataset2$age > 30 & dataset2$age <= 55] <- "청년층"
dataset2$age2[dataset2$age > 55] <- "청년층"

dataset2[c("age","age2")]

########################################################################################################

####################
# 2. 카이제곱 검정
####################


# 귀무가설 : 부모의 학력수준이 자녀의 대학진학에 영향을 미치는가?

CrossTable(x=df$Level, y=df$Pass, chisq = TRUE)
# Chi^2 =  2.766951     d.f. =  2     p =  0.2507057 
# 검정통계량 : chi^2, d.f.
# 유의 확률 : p =  0.2507057 >= 유의수준(0.05)

# chi^2 = .766951
chi_2 = 0.544 + 0.363 + 1.026 + 0.684 + 0.091 + 0.060 # 모든셀의 기대값을 더한다.
chi_2


# d.f. = 2
# 자유도(D.F) : 샘플수(n)에서 자유롭게 선택한 수 
# n-1
df = (3-1) * (2-1)
df # 2



# [해설] 학력수준과 대학진학은 관련이 없다고 볼 수 있다.




#######################################
##  2. 카이제곱 검정 : CrossTable() 이용
#######################################

# 1) 일원카이제곱 

# 적합도/선호도 검정 
# - chisq.test() 함수를 이용하여 관찰치와 기대빈도 일치여부 검정

# (1) 적합성 검정 예
#-----------------------------------------------
# 귀무가설 : 기대치와 관찰치는 차이가 없다. 
# 대립가설 : 기대치와 관찰치는 차이가 있다. 
#-----------------------------------------------
# 가설 설정 방법
# 귀무가설 : 같다 = 다르지않다 = 차이가 없다 = 효과가 없다
# 대립가설 : 같지않다 = 다르다 = 차이가 있다 = 효과가 있다

# 60회 주사위를 던져서 나온 관측도수/기대도수
# 관측도수 : 4(1), 6(2), 17(3), 16(4), 8(5), 9(6)
# 기대도수 : 10,10,10,10,10,10

chisq.test(c(4,6,17,16,8,9))
# X-squared = 14.2, df = 5, p-value = 0.01439

#<유의확률 해석>
#유의확률(p-value : 0.01439)이 0.05미만이기 때문에 유의미한 수준(α=0.05)에서 귀무가설을 기각할 수 있다.


# <검정통계량 해석>
# X-squared= 14.2, df = 5
# X-squared >= 11.071 #(table) -> 기각


# (2) 선호도 분석 
#-----------------------------------------
# 귀무가설 : 기대치와 관찰치는 차이가 없다. 
# 대립가설 : 기대치와 관찰치는 차이가 있다. 
#-----------------------------------------
data <- textConnection(
  "스포츠음료종류  관측도수
  1   41
  2   30
  3   51
  4   71
  5   61
  ")
x <- read.table(data, header=T)
x # 스포츠음료종류 관측도수

chisq.test(x$관측도수)
#X-squared = 20.4882, df = 4, p-value = 0.0003999

#<유의확률 해석>
#유의확률(p-value : 0.0003999)이 0.05미만이기 때문에 유의미한 수준(α=0.05)에서 귀무가설을 기각할 수 있다. 





#2) 이원카이제곱 - 교차분할표 이용

################################
# (1) 독립성/관련성 검정 
################################  
# - 동일 집단의 두 변인(학력수준과 대학진과 여부)을 대상으로 관련성이 있는가 없는가?

# 귀무가설 : 부모의 학력수준과 자녀의 대학진학 여부와 관련성이 없다.
# 대립가설 : 부모의 학력수준과 자녀의 대학진학 여부와 관련성이 있다.

# 독립변수(x)와 종속변수(y) 생성 
setwd("c:/Rwork/data")

data <- read.csv("cleanDescriptive.csv")
str(data)


x <- data$level2 # 부모의 학력수준
y <- data$pass2 # 자녀의 대학진학여부 

CrossTable(x, y, chisq = TRUE) #p =  0.2507057    
#Pearson's Chi-squared test 


# <논문에서 교차분석과 카이제곱 검정 결과 제시방법>

################################
# (2) 동질성 검정 
################################
# 두 집단의 분포가 동일한가? 다른 분포인가?
# 예) 교육방법에 따른 만족도 : 집단 간 차이가 없다.(동질성 검정)

# 1. 파일 가져오기
data <- read.csv("homogenity.csv", header=TRUE)
head(data) 
table(data$method)
table(data$survey)
# method와 survery 변수만 서브셋 생성
data <- subset(data, !is.na(survey), c(method, survey)) 
data
# 2. 변수리코딩 - 코딩 변경
# method: 1:방법1, 2:방법2, 3:방법3 
# survey: 1:매우만족, 2:만족, 3:보통, 4: 불만족, 5: 매우불만족

# 교육방법2 필드 추가
data$method2[data$method==1] <- "방법1" 
data$method2[data$method==2] <- "방법2"
data$method2[data$method==3] <- "방법3"

# 만족도2 필드 추가
data$survey2[data$survey==1] <- "매우만족"
data$survey2[data$survey==2] <- "만족"
data$survey2[data$survey==3] <- "보통"
data$survey2[data$survey==4] <- "불만족"
data$survey2[data$survey==5] <- "매우불만족"


# 3. 교차분할표 작성 
table(data$method2, data$survey2)  # 교차표 생성 -> table(행,열)
#         만족 매우만족 매우불만족 보통 불만족
# 방법1    8        5          6   15     16 -> 50
# 방법2   14        8          6   11     11 -> 50
# 방법3    7        8          9   11     15 -> 50
# 주의 : 반드시 각 집단별 길이(50)가 같아야 한다.

# 4. 동질성 검정 - 모수 특성치에 대한 추론검정  
chisq.test(data$method2, data$survey2) 
# p-value = 0.5865 >= 0.05


# 5. 동질성 검정 해석
# 교육방법(집단)에 따른 만족에 차이가 없다고 볼 수 있다.





########################################################################################################


# 2-2. 두 집단 평균차이 검정

data <- read.csv("c:/Rwork/Part-III/two_sample.csv", header=TRUE)
data
print(data)
head(data) #4개 변수 확인
summary(data) # score - NA's : 73개

# 2) 두 집단 subset작성(데이터 정제,전처리)
result <- subset(data, !is.na(score), c(method, score))
# c(method, score) : data의 전체 변수 중 두 변수만 추출
# !is.na(score) : na가 아닌 것만 추출
# 위에서 정제된 데이터를 대상으로 subset 생성
result # 방법1과 방법2 혼합됨
length(result$score) # 227

# 데이터 분리
#1) 교육방법 별로 분리
a <- subset(result,method==1)
b <- subset(result,method==2)

#2) 교육방법에서 점수 추출
a1 <- a$score
b1 <- b$score

# 기술통계량 -> 평균값 적용 -> 정규성 검정 필요
length(a1); # 109
length(b1); # 118


# 3)분포모양 검정 : 두 집단의 분포모양 일치 여부 검정
# 귀무가설 : 두 집단 간 분포의 모양이 동질적이다.
# 두 집단간 동질성 비교(분포모양 분석)
var.test(a1, b1) # p-value = 0.3002 -> 차이가 없다.
# 동질성 분포 : t.test()
# 비동질성 분포 : wilcox.test()


# 4) 가설검정 – 두 집단 평균 차이검정
t.test(a1, b1)
t.test(a1, b1, alter="two.sided", conf.int=TRUE, conf.level=0.95)
# p-value = 0.0411 - 두 집단간 평균에 차이가 있다.

# 대립가설 : a1 > b1
t.test(a1, b1, alter="greater", conf.int=TRUE, conf.level=0.95)
# p-value = 0.9794 : a1을 기준으로 비교 -> a1이 b1보다 크지 않다.

# 대립가설 : a1 < b1
t.test(a1, b1, alter="less", conf.int=TRUE, conf.level=0.95)
# p-value = 0.02055 : a1이 b1보다 작다.

mean(a1) # 5.556881
mean(b1) # 5.80339

########################################################################################################

# 3. 공분산
# - 두 변수의 확률분포의 상관관계 정도를 나타내는 값

# 상관계수 vs 공분산
# 상관계수 : 크기, 방향(-, +)
# 공분산 : 크기 

cov(product) # 공분산 행렬

#               제품_친밀도  제품_적절성  제품_만족도
# 제품_친밀도   0.9415687    0.4164218     0.3756625
# 제품_적절성   0.4164218    0.7390108     0.5463331
# 제품_만족도   0.3756625    0.5463331     0.6868159



###############
## iris 적용
###############
cor(iris[-5])

#               Sepal.Length  Sepal.Width  Petal.Length  Petal.Width
# Sepal.Length    1.0000000   -0.1175698    0.8717538    0.8179411
# Sepal.Width    -0.1175698    1.0000000   -0.4284401   -0.3661259
# Petal.Length    0.8717538   -0.4284401    1.0000000    0.9628654
# Petal.Width     0.8179411   -0.3661259    0.9628654    1.0000000

# 양의 상관계수(0.9628654)
plot(iris$Petal.Length, iris$Petal.Width)

# 음의 상관계수(-0.4284401)
plot(iris$Petal.Length, iris$Sepal.Width)



########################################################################################################



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


###############################################
# 15_2. 로지스틱 회귀분석(Logistic Regression) 
###############################################

# 단계1. 데이터 가져오기
weather = read.csv("C:/Rwork/data/weather.csv", stringsAsFactors = F) 
dim(weather)  # 366  15
head(weather)
str(weather)


# chr 칼럼, Date, RainToday 칼럼 제거 
weather_df <- weather[, c(-1, -6, -8, -14)]
str(weather_df) # 11개 칼럼만 남음

# RainTomorrow 칼럼 -> 로지스틱 회귀분석 결과(0,1)에 맞게 더미변수 생성      
weather_df$RainTomorrow[weather_df$RainTomorrow=='Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow=='No'] <- 0
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow)
head(weather_df)

#  단계2.  데이터 셈플링 70 vs 30
idx <- sample(1:nrow(weather_df), nrow(weather_df)*0.7)
train <- weather_df[idx, ]
test <- weather_df[-idx, ]


#  단계3.  로지스틱  회귀모델 생성 : 학습데이터 
weater_model <- glm(RainTomorrow ~ ., data = train, family = 'binomial')
weater_model 
summary(weater_model) 
?glm



# 단계4. 로지스틱  회귀모델 예측치 생성 : 검정데이터 
# newdata=test : 새로운 데이터 셋, type="response" : 0~1 확률값으로 예측 
pred <- predict(weater_model, newdata=test, type="response")  
pred 
range(pred, na.rm = T) # 0.001175185  ~  0.992686899
summary(pred)
str(pred) # Named num [1:110]

# cut off = 0.5 적용
cpred <- ifelse(pred >= 0.5, 1, 0) # 예측치(0, 1)
cpred
y_true <- test$RainTomorrow # 정답(0, 1)

table(y_true, cpred)

##아래가 평가과정!

# 교차분할표(confusion matrix)
t <- table(y_true, cpred)
t
#cpred
# y_true  No Yes
#     0  87   5   = 92(no)
#     1  10   8   = 18(yes)


# model 평가 : 분류정확도
acc <- (87+8) / sum(t)
cat('accuracy=', acc) #accuracy = 0.8636364
acc

(4+8)/sum(t) # 0.1090909

# 특이도 : NO -> NO
acc_no <- 83/87 # 0.954023
acc_no

# 재현률(민감도) : YES -> YES
recall <- 13/21 # 0.6190476
recall

# 정확률 : model(yes) -> yes
precision <- 13 / 17


# F1 Score : no != yes(불균형)
f1_score = 2*((precision * recall) / (precision + recall))
f1_score # 0.6842105





### ROC Curve를 이용한 모형평가(분류정확도)  ####
# Receiver Operating Characteristic

install.packages("ROCR")
library(ROCR)

# ROCR 패키지 제공 함수 : prediction() -> performance
pr <- prediction(pred, test$RainTomorrow)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

##########################
# 다항형 로지스틱 회귀분석
##########################

install.packages("nnet")
library(nnet)


# 이항분류 vs 다항분류
# sigmoid : 이항분류(0~1확률, cutoff=0.5)
# softmax : 다항분류(0~1확률, 확률합 = 1)
# ex) class1=0.9, class2=0.1, class3=0.1
names(iris)

idx <- sample(nrow(iris), nrow(iris)*0.7)
train_iris <- iris[idx, ]
test_iris <- iris[-idx, ]


# 다항분류 ㅡ model
model <- multinom(Species ~ .,data = train_iris)

# model 평가 : test
y_pred <- predict(model, test_iris, type = "probs") 
# type = "probs"  : 확률로 결과를 반환 (합 = 1)
# 
#           setosa    versicolor     virginica
# 1   9.999999e-01  9.782944e-08  1.245832e-28 -> 행의 확률을 모두 더하면 1이라는 뜻임

y_pred <- predict(model, test_iris, type = "class") 
# type = "class" : 클래스로 결과를 반환 
range(y_pred) 0
# 6.439751e-35 ~ 1.000000e+00


y_true <- test_iris$Species

t <- table(y_true, y_pred)

acc <-(t[1,1] + t[2,2] + t[3,3]) / sum (t)
acc # 0.9555556


