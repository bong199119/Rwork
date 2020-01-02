x <- c(1:5)
x
y<- c(1,3,9)
y[1]
y[3]
a <- c(1:100)
a
a[50:77]

length(a)
m1 <- matrix(c(1:9),nrow = 3)
m1
m2 <- matrix(c(1,2,3,4,1,2,3,4,5,6,6,2),ncol = 5)
m2

x1 <- 1:5
x2 <- 2:6
m2 <- cbind(x1,x2)
m2
colnames(m2) <- c("one","two")
m2

x<- 1:3
y<-matrix(1:6,nrow=2)
y
z<-x*y
z


apply(z,1,sum)
apply(z,2,sum)

arr <- array(1:12, c(3,2,2))
arr

arr[..1]


no <- 1:3
name <- c("홍","봉","상")
age <- c(35,45,25)
pay <- c(200,300,150)

emp <- data.frame(no, name, age,pay)
emp
epay <- emp$Pay
epay

var(epay)
sqrt(var(epay))
sd(epay)

list <- list('lee','이순신',29,'hong','홍길동',45)
list[1]
list[[1]]


getwd()
student <- read.table("student1.txt",header = T, sep="")
student


student1 <- read.table("student1.txt",header = T, sep ="")
student1

student2 <- read.table("student2.txt", header = T, sep=";")
student2

bmi <- read.csv("bmi.csv")
bmi

str(bmi)

table(bmi$weight)

test <- read.csv(file.choose())



titanic <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")
titanic

dim(titanic)
table(titanic$age)
table(titanic$sex)
table(titanic$survived)
tab<- table(titanic$sex, titanic$survived)
tab
x<- FALSE
y<- FALSE
xor(x,y)



score <- c(90,10,NA,12,44)
score
mean <- mean(score, na.rm=T)
result <- ifelse(is.na(score), mean, score)
result



library("MASS")
data("Boston")
data

str(Boston)
Boston

cols <- names(Boston)
cols
idx <- which(cols == "medv")
idx


num<- scan()

getwd()
st <- read.table("student.txt")
st

colnames(st) <- c("sid","name","height","weight")
st
height2 <- ifelse(st$height >= 180, "high","row")
st$height2 <- height2
st
weight2 <- ifelse(st$weight >=70, "heavy","light")
st$weight2 <- weight2
st
