# chap02_DataStructure

# 1. vector 자료구조
# - 동일 자료형을 갖는 1차원 배열 구조
# - c(), seq(), rep()

# c()함수
x <- c(1:5)
x
y <- c(1,3,5)
y

# seq()
seq(1, 9, by=2) #(start, end, step)
seq(9, 1, by=-2) 

# rep()

rep(1:3, 3) # 1 2 3 1 2 3 1 2 3
rep(1:3, each=3) #1 1 1 2 2 2 3 3 3

# 색인(index) : 자료의 위치
# R index = 1부터 시작
a <- c(1:100)
a #[1] <- index  1<- content
a[100] # 100
a[50:60]
a[90:20]
length(a)
length(a[50:60]) # 11
a[(length(a)-5) : length(a)]
a[length(a)-5:length(a)]
a[100-5:100]



start = length(a)-5
end = length(a)
a[start:end]

a[a>=10 & a<=50]


# 2. matrix 자료구조
# - 동일한 자료형을 갖는 2차원(행,열) 배열
# - 생성 함수 : matrix(), rbind(), cbind()

# matrix()
m1 <- matrix(c(1:9), nrow =3)
m1
dim(m1) # 3 3

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

x <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
# byrow를 트루로 잡으면 행우선으로 채워넣기 시작함
# 이게없으면 열우선으로 인자를 채워넣는다.

x
colnames(x) <- c("one","two","three")
x

# scala(0), vector(1), matrix(2)


# broadcast 연산
# 1) vector vs scala
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

# 3. array
# - 동일한 자료형을 갖는 3차원 배열구조

arr <- array(1:12, c(3,2,2))
arr
dim(arr) # 3(row) 2(col) 2(side)

arr[..1] # 1면
arr[..2] # 2면

# 4. data.frame
# - 행렬구조를 갖는 자료구조
# - 칼럼단위 서로 상이한 자료형을 갖는다.

no <- 1:3
name <- c("홍길동","이순신","유관순")
age <- c(35,45,25)
pay <- c(200,300,150)

emp <- data.frame(NO=no, Name=name, Age=age, Pay=pay)
emp
#obj$column
epay <- emp$Pay
epay

mode(epay) # numeric

# 분산과 표준 편차

var(epay)
sqrt(var(epay)) # 루트
sd(epay) 


score <- c(90,85,83)
# 분산
var(score) # 13
# 표준편차 : 분산의 양의 제곱근
sd(score) # 3.605551
sqrt(var(score)) # 3.605551


#분산 = sum((x-산술평균)^2) / n-1
avg <- mean(score) # 산술평균
diff <- (score - avg)^2
diff_sum <- sum(diff)
var <- diff_sum / (length(score) - 1)
var # 13


sd <- sqrt(var)
sd

# 5. list 자료구조
# - 서로 다른 자료형(숫자, 문자, 논리형)과 자료구조(1,2,3)를
# 갖는 자료구조
# - key = value (python : dict)

# 1) key 생략 : [key =] value
list <- list('lee',"이순신",29,"hong","홍길동",45)
#[[1]] -> default key
#[1] "lee" -> value(string)

#[[6]] -> default key
#[1] 45 -> value(int)

# key -> value 접근
list[[1]]  #-> "lee"의 key
list[[2]]  #-> "이순신"의 key


# index -> key:value 접근
list[4] # -> [[4]],  "hong"
#[[4]] -> key
#[4] -> value










 








