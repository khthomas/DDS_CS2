
#Steven Hayden
#1124/2017

#install packages and libraries required. 

#install.packages("rvest")
#install.packages("dplyr")

library(rvest)
library(dplyr)




# Enter in URL and pull in data
URL<-'https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries'
webpage<- read_html(URL)

#identify nodes
Country_Table<-html_nodes(webpage,"table")


################################Combine Wiki tables into one table###########################################
#stores the first table into the Country.df Data Frame
Country.df<-data.frame(html_table(Country_Table[4],fill = TRUE))

#Stores the length of the first table in case the size of the table changes in the future. Also used for the length of Human Development level column
Table.length<- length (data.frame( html_table(Country_Table[c(4)],fill = TRUE))[,1])+1 # pluse one to count the header


#labels the rows by the by the Human development level based on what table was pulled in
Country.df[1:Table.length,"Human Development Level"]<-"Very high human development"



#############Binds the secound table
Country.df<-rbind_list(Country.df, data.frame( html_table(Country_Table[c(5)],fill = TRUE)))


# Move the first tables country column to the same Column as the rest of the tables
Country.df[1:Table.length,"Country"]<-Country.df[1:Table.length,"Country.Territory"]


#Stores the length of the  table in case the size of the table changes in the future. Also used for the length of Human Development level column
Table.length2<- length (data.frame( html_table(Country_Table[c(5)],fill = TRUE))[,1])+1 # plus one to count the header
Country.df[Table.length+1:Table.length2,"Human Development Level"]<-"Very high human development"
Table.length<-Table.length2 + Table.length



#############Binds the third table  
Country.df<-rbind_list(Country.df, data.frame( html_table(Country_Table[7],fill = TRUE)))

#Stores the length of the  table in case the size of the table changes in the future. Also used for the length of Human Development level column
Table.length2<- length (data.frame( html_table(Country_Table[c(7)],fill = TRUE))[,1])+1 # plus one to count the header
Country.df[Table.length+1:Table.length2,"Human Development Level"]<-"High human development"
Table.length<-Table.length2 + Table.length



#############Binds the fourth table 
Country.df<-rbind_list(Country.df, data.frame( html_table(Country_Table[c(8)],fill = TRUE)))

#Stores the length of the  table in case the size of the table changes in the future. Also used for the length of Human Development level column
Table.length2<- length (data.frame( html_table(Country_Table[c(8)],fill = TRUE))[,1])+1 # plus one to count the header
Country.df[Table.length+1:Table.length2,"Human Development Level"]<-"High human development"
Table.length<-Table.length2 + Table.length




#############Binds the fifth  table 
Country.df<-rbind_list(Country.df, data.frame( html_table(Country_Table[c(10)],fill = TRUE)))

#Stores the length of the  table in case the size of the table changes in the future. Also used for the length of Human Development level column
Table.length2<- length (data.frame( html_table(Country_Table[c(10)],fill = TRUE))[,1])+1 # plus one to count the header
Country.df[Table.length+1:Table.length2,"Human Development Level"]<-"Medium human development"
Table.length<-Table.length2 + Table.length




#############Binds the sixth table 

Country.df<-rbind_list(Country.df, data.frame( html_table(Country_Table[c(11)],fill = TRUE)))

#Stores the length of the  table in case the size of the table changes in the future. Also used for the length of Human Development level column
Table.length2<- length (data.frame( html_table(Country_Table[c(11)],fill = TRUE))[,1])+1 # plus one to count the header
Country.df[Table.length+1:Table.length2,"Human Development Level"]<-"Medium human development"
Table.length<-Table.length2 + Table.length




#############Binds the seventh table
Country.df<-rbind_list(Country.df, data.frame( html_table(Country_Table[c(13)],fill = TRUE)))

#Stores the length of the  table in case the size of the table changes in the future. Also used for the length of Human Development level column
Table.length2<- length (data.frame( html_table(Country_Table[c(13)],fill = TRUE))[,1])+1 # plus one to count the header
Country.df[Table.length+1:Table.length2,"Human Development Level"]<-"Low human development"
Table.length<-Table.length2 + Table.length



#############Binds the eighth table
Country.df<-rbind_list(Country.df, data.frame( html_table(Country_Table[c(14)],fill = TRUE)))

#Stores the length of the  table in case the size of the table changes in the future. Also used for the length of Human Development level column
Table.length2<- length (data.frame( html_table(Country_Table[c(14)],fill = TRUE))[,1])+1 # plus one to count the header
Country.df[Table.length+1:Table.length2,"Human Development Level"]<-"Low human development"
Table.length<-Table.length2 + Table.length

##############################Clean Data#######################################################

#remove columns that are not needed
Country.df<-Country.df[,-c(1:3,5)]
View(Country.df)

#Remove headers in rows that are left over from when the data was in separate tables
Country.df<-Country.df[-which(Country.df$Country =="Change in rank from previous year[1]"),]
Country.df<-Country.df[!is.na(Country.df$Country),]









