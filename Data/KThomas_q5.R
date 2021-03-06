---
  title: "Case_Study_Two"
author: "Matt Rega"
date: "November 26, 2017"
output: html_document
---
  
  ```{r}
#read in data set
library(readr)
library(dplyr)
library(stringi)
library(rvest)
library(xml2)
library(selectr)
library(ggplot2)
setwd("~/SMU/DDS_CS2/Data")
df = read.csv("Procrastination.csv")
Procrastination = read.csv("Procrastination.csv")
# Procrastination <- read_csv("C:/Users/student/Desktop/Doing DS/Case_Study_2/Procrastination.csv")

#Print number of rows and columns
dimPro<-dim(Procrastination)
names(dimPro)<-c("Number of Rows", "Number of Columns")
dimPro

#Clean up column names of the data set
ProColNames<-names(Procrastination)

#remove spaces from names
ProColNames<-gsub(" ","",ProColNames[1:length(ProColNames)],fixed = TRUE)

#Current Occupation-->Occupation
ProColNames[7]<-"Occupation"

#How long.....years
ProColNames[8]<-"TenureYears"

#How long...months
ProColNames[9]<-"TenureMonths"

#community size
ProColNames[10]<-"CommSize"

#county of residence
ProColNames[11]<-"Country"

#marital status
ProColNames[12]<-"MaritalStat"

#number of sons/daughters
ProColNames[13]<-"Sons"
ProColNames[14]<-"Daughters"

#all the scale questions 15-59
## Kyle -- I get an error here. I don't think this gets used. When I run grep(")", ProColNames) I get zero results.
##        may want to consider removing this section. 

#original
# for(i in 15:59)
# {
# ProColNames[i]<-substr(ProColNames[i],2,which(strsplit(ProColNames[i],"")[[1]] == ")" )-1)
# }

#based on this it looks like we are trying to split the string to make column names. I propose the below:
#IT does the following:
# replace periods with blanks
# replace â with blanks
# Uses regex to find the first few letters followed by a number in the string
# extract the rest of the string to the first 12 letters of the column name

for (i in 15:59)
{
  ProColNames[i] = gsub("\\.","", ProColNames[i])
  ProColNames[i] = gsub("â","", ProColNames[i])
  holding = stringr::str_locate_all(pattern = "[A-Z\\.]+[0-9]", ProColNames[i])
  ProColNames[i] = substr(ProColNames[i], holding[[1]][2] + 1, 13 + holding[[1]][2])
}

#do you consider yourself.....
ProColNames[60]<-"YouConsider"

#do others ocnsider....
ProColNames[61]<-"OtheConsider"

#Assign names to data set
names(Procrastination)<-ProColNames

#Remove tenure in years that are greater than 100
Procrastination<-Procrastination[-which(Procrastination[8]>100),]

#Change male to 1 and female to 2 in the number of sons column
Procrastination$Sons[which(Procrastination$Sons=="Male")]<-1
Procrastination$Sons[which(Procrastination$Sons=="Female")]<-2

#Remove 0 from country column
Procrastination$Country[Procrastination$Country==0]<-NA

#Remove 0 and please specify from occupation column
Procrastination$Occupation[Procrastination$Occupation==0]<-NA
Procrastination$Occupation[Procrastination$Occupation=="please specify"]<-NA

#Group similar occupations together

#Student
for (i in 1:length(Procrastination$Occupation))
{
  
  if(grepl("student",Procrastination$Occupation[i]))
    Procrastination$Occupation[i]<-"Student"
  
  if(grepl("Student",Procrastination$Occupation[i]))
    Procrastination$Occupation[i]<-"Student"
  
}#end for

#teacher
for (i in 1:length(Procrastination$Occupation))
{
  
  if(grepl("teacher",Procrastination$Occupation[i]))
    Procrastination$Occupation[i]<-"Teacher"
  
  if(grepl("Teacher",Procrastination$Occupation[i]))
    Procrastination$Occupation[i]<-"Teacher"
  
}#end for

#Manager
for (i in 1:length(Procrastination$Occupation))
{
  
  if(grepl("manager",Procrastination$Occupation[i]))
    Procrastination$Occupation[i]<-"Manager"
  
  if(grepl("Manager",Procrastination$Occupation[i]))
    Procrastination$Occupation[i]<-"Manager"
  
}#end for

#Self-Employed
for (i in 1:length(Procrastination$Occupation))
{
  
  if(grepl("self-employed",Procrastination$Occupation[i]))
    Procrastination$Occupation[i]<-"Self-Employed"
  
  if(grepl("Self-Employed",Procrastination$Occupation[i]))
    Procrastination$Occupation[i]<-"Self-Employed"
  
}#end for

#Writer
for (i in 1:length(Procrastination$Occupation))
{
  
  if(grepl("Writer",Procrastination$Occupation[i]))
    Procrastination$Occupation[i]<-"Writer"
  
  if(grepl("writer",Procrastination$Occupation[i]))
    Procrastination$Occupation[i]<-"Writer"
  
}#end for

#Change columns to correct data types
Procrastination$TenureYears<-round(as.numeric(format(Procrastination$TenureYears,scientific = FALSE),0))
Procrastination$Sons<-as.numeric(Procrastination$Sons)

#Take the mean of the scale questions
Procrastination$DPMean<-round(rowMeans(Procrastination[15:19],na.rm = TRUE),1)
Procrastination$AIPMean<-round(rowMeans(Procrastination[20:34],na.rm = TRUE),1)
Procrastination$GPMean<-round(rowMeans(Procrastination[35:54],na.rm = TRUE),1)
Procrastination$SWLSPMean<-round(rowMeans(Procrastination[55:59],na.rm = TRUE),1)

```


# Question 3: Scrape the Human Development Index

```{r q3}
url = "https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index"

page = read_html(url)

#get the table info -- this was for testing
# table = page %>%
#   rvest::html_nodes(xpath = "//td//table") %>%
#   .[1] %>%
#   rvest::html_table(fill = TRUE)

#assing them in a loop
for(i in 1:8) {
  assign(paste0("table", i), as.data.frame(page %>%
                                             rvest::html_nodes(xpath = "//td//table") %>%
                                             .[i] %>%
                                             rvest::html_table(fill = TRUE)
  )
  )
  
}

colnames(table1) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table2) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table3) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table4) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table5) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table6) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table7) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table8) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")

dfHDI = rbind(table1[-1,], table2[-1,], table3[-1,], table4[-1,], table5[-1,], table6[-1,], table7[-1,], table8[-1,])

dfHDI = dfHDI[,c("Country", "2016_Est_HDI")]

dfHDI$HDI_Category = ifelse(dfHDI$`2016_Est_HDI` >= 0.8, "Very High",
                            ifelse(dfHDI$`2016_Est_HDI` >= 0.7, "High",
                                   ifelse(dfHDI$`2016_Est_HDI` >= 0.55, "Medium", "Low")))

##Make classificaiton of HDI based on score


Procrastination = merge(Procrastination, dfHDI, by = "Country")

#Q5B Barchart
countryGPmean = aggregate(GPMean ~ Country + HDI_Category, Procrastination, mean)
sortedGP = countryGPmean[order(countryGPmean$GPMean, decreasing = TRUE),][1:15,]


ggplot(data=sortedGP, aes(x= reorder(Country, -GPMean), y = GPMean, fill = HDI_Category)) + 
  geom_bar(stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90)) + 
  xlab("Country") + 
  ylab("Mean General Procrastination Score") + 
  ggtitle("Top 15 Countries by Average General Procrastination Scale") + 
  scale_fill_brewer(palette = "Dark2")


#Q5C Barchart
countryGPmean = aggregate(DPMean ~ Country + HDI_Category, Procrastination, mean)
sortedDP = countryGPmean[order(countryGPmean$DPMean, decreasing = TRUE),][1:15,]

ggplot(data=sortedDP, aes(x= reorder(Country, -DPMean), y = DPMean, fill = HDI_Category)) + 
  geom_bar(stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90)) + 
  xlab("Country") + 
  ylab("Mean General Procrastination Score") + 
  ggtitle("Top 15 Countries by Average Decisional Procrastination Scale") + 
  scale_fill_brewer(palette = "Dark2")

#Which countries are similar



  
  


