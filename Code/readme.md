# Code Book

## R Libraries Utilized in this Report
readr
dplyr
stringi
rvest
xml2
selectr
ggplot2
sqldf


## Pulling Human Development Index Data from Wikipedia

### Introduction to the Human Development Index
According to Wikipedia, the Human Development Index (HDI) is: 

".. a composite statistic of life expectancy, education, and income per capita indicators. A country scores higher HDI when the life
 expectancy at birth is longer, the education period is longer, and the income per capita is higher. It is used to distinguish whether the
 country is a developed, a developing or an underdeveloped country."

As such, it is a useful statistic when analyzing employee sentiment and procrastination scores by providing contextual information about
 the country in which an employee resides.

Wikipedia has tables with the HDI information for each country. This data was scrapped and incorporated into this analysis.


### Scrapping Process and Outputs
The wikipedia webpage that was used to coallate this data was: https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index 

The primary library utilized to pull this data was rvest. Please note that some people have issues with some of the dependencies in rvest.
If problems are encountered when trying to run the R code to scrape the webpage please try reinstalling the "selectr" package.

The tables that are pulled by the code are under the "Complete list of countries" section of the webpage. This is accomplished by looping
through the webpages and assiging them to their individual data frames and then stacking these datasets. The HDI_Category was created by
looking at the cutoff points for each HDI level in the Wikipedia tables. The code used to scrape the Wikipedia tables is shown below.

```{r webscrape}
#assign them in a loop
for(i in 1:8) {
  assign(paste0("table", i), as.data.frame(page %>%
  rvest::html_nodes(xpath = "//td//table") %>%
  .[i] %>%
  rvest::html_table(fill = TRUE)
  )
  )
 
}

#change the column names
colnames(table1) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table2) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table3) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table4) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table5) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table6) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table7) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")
colnames(table8) = c("2016_Est_Rank", "Rank_Change", "Country", "2016_Est_HDI", "HDI_Change")

#Stack the data. Note that the first row is dropped from each. This is because undefined column names were brought in
#during the scrapping process.
dfHDI = rbind(table1[-1,], table2[-1,], table3[-1,], table4[-1,], table5[-1,], table6[-1,], table7[-1,], table8[-1,])

#select only the Country and 2016 HDI values
dfHDI = dfHDI[,c("Country", "2016_Est_HDI")]

#Assign HDI categories based on HDI score
dfHDI$HDI_Category = ifelse(dfHDI$`2016_Est_HDI` >= 0.8, "Very High",
                            ifelse(dfHDI$`2016_Est_HDI` >= 0.7, "High",
                                   ifelse(dfHDI$`2016_Est_HDI` >= 0.55, "Medium", "Low")))

#Merge the HDI data with the main data frame
Procrastination = merge(Procrastination, dfHDI, by = "Country")
```

## Top 15 Countries by General Procrastination (GP) and Decisional Procrastination (DP) Scales 
The top 15 countires with the highest **mean** GP and DP scores were identified by aggregating the mean scores by Country and HDI_Category.
Once the top 15 countries were identified by each score, a simple bar chart was created to help visualize the data. There were 9 countries
that appeard in both analysis. These countries are:

Country | Mean GP | Mean DP
 --- | --- | ---
Austria | 3.76 | 4.06
Ecuador | 3.7 | 4.13
Estonia | 3.8 | 4.4
Panama | 4.0 | 5.0
Portugal | 3.64 | 3.87
Qatar | 4.2 | 5.0
Slovenia | 3.66 | 4.0 
Sri Lanka | 3.8 | 4.4
Uruguay | 3.66 | 3.93

**Top 15 Countries by DP**
![GP Image](https://raw.githubusercontent.com/khthomas/DDS_CS2/master/Code/dpmean.JPG)

**Top 15 Countries by GP**
![DP Image](https://raw.githubusercontent.com/khthomas/DDS_CS2/master/Code/dpmean.JPG)




## Frequently Asked Questions (FAQ)
Q1: I cannot scrape the wikipedia webpage.
A1: Some people may have a bad installation of the selectr package. Please try reinstalling this package (install.packages("selectr"))