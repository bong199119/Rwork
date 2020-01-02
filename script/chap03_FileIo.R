# chap03_FileIo

# 1. 파일 자료 읽기
getwd()
setwd("c:/Rwork/data")
getwd()

# (1) read.table() : 칼럼 구분자(공백, 특수문자)

# - 칼럼명이 없는 경우
student <- read.table("student.txt") # header = FALSE, sep = ""
student

# 기본 칼럼명 : v1 v2 v3 v4

# - 칼럼명이 있는 경우
student1 <- read.table("student1.txt", header = TRUE, sep = "")
student1
class(student1)

# - 칼럼 구분자 : 특수문자 (:, :, ::)
student2 <- read.table("student2.txt", header = TRUE, sep=";")
student2

# - (2) read.csv() : 칼럼 구분자 콤마(,)
bmi <- read.csv("bmi.csv")
bmi 
str(bmi)

# 'data.frame':	20000 obs. of  3 variables:
#   $ height: (숫자형)int  184 189 183 143 187 161 186 144 184 165 ...
# $ weight: (숫자형)int  61 56 79 40 66 52 54 57 55 76 ...
# $ label : (범주형)Factor w/ 3 levels "fat","normal",..: 3 3 2 2 2 2 3 1 3 1 ...

h<- bmi$height
h
mean(h)
w <-bmi$weight
mean(w)
max(w)
max(h)
min(w)
min(h)

# 범주형 빈도
table(bmi$label)
# fat(1) normal(@)   thin(3) 
# 7425   7677   4898 

# 문자형 -> 문자형
bmi2 <- read.csv("bmi.csv", stringsAsFactors = FALSE)
str(bmi2)

#$label : chr

# 파일 탐색기 이용
test <- read.csv(file.choose()) # test.csv
test

# (3) read.xlsx() : 패키지 설치
install.packages("xlsx")
library(xlsx)

kospi <- read.xlsx("sam_kospi.xlsx", sheetIndex = 1)
kospi
head(kospi)


# 한글 엘셀 파일 읽기 : encoding 방식
st_excel <- read.xlsx("studentexcel.xlsx",
                      sheetIndex = 1,
                      encoding = "UTF-8")
st_excel


# 데이터 셋 제공 사이트 
# http://www.public.iastate.edu/~hofmann/data_in_r_sortable.html - Datasets in R packages
# https://vincentarelbundock.github.io/Rdatasets/datasets.html
# https://r-dir.com/reference/datasets.html - Dataset site
# http://www.rdatamining.com/resources/data

# 미국의 각 주별 1인당 소득자료  
# url <- "http://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

# (4) 인터넷 파일 읽기
titanic <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")
str(titanic)

dim(titanic) # 1316    5

# 성별 빈도수
table(titanic$sex)
# 생존 여부 빈도수
table(titanic$survived)

# 교차분할표 : 2개 범주형(행, 열)
tab <- table( titanic$survived, titanic$sex)
barplot(tab)


# 막대차트
barplot(tab, col = rainbow(2), main = "생존여부")

# 2. 파일 자료 저장

# 1) 화면 출력
a <- 10
b <- 20
c <- a * b
print(c) # 200
c # 200
cat('c=',c)  # c=200

# 2) 파일 저장
# read.csv <-> write.csv
# read.xlsx <-> write.xlsx

getwd()
setwd("c:/Rwork/data/output")

# (1) write.csv() : 콤마 구분자
str(titanic)
# 'data.frame':        1316 obs. of  5 variables:

# 1칼럼 제외, 따움표 제거, 행번호 제거
write.csv(titanic[-1],"titanic.csv",quote=F,row.names=FALSE)

titan <- read.csv("titanic.csv") 
head(titan)

# (2) write.xlsx() : 엑셀 파일 저장
library(xlsx)
write.xlsx(kospi,"kospi.xlsx",sheetName = "sheet1", row.names = F)











