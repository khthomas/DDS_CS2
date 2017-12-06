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
knitr
kableExtra
Shiny
rworldmap

## Session Info

**Analyst 1** 

R version 3.4.2 (2017-09-28)

Platform: x86_64-w64-mingw32/x64 (64-bit)

Running under: Windows 7 x64 (build 7601) Service Pack 1

## List of All Objects Utilized in this dataset (not including helper objects) and a brief description
* **countryDPmean** - Country, HDI_Category, 2016 Estimated HDI, DP mean score
* **countryGPmean** - Country, HDI_Category, 2016 Estimated HDI, GP mean score
* **CountryTable** - Country and the number of participants in the survey
* **Descriptive_Table** - Places the "Annual.Income", "Age", "2016_Est_HDI", "DPMean", "GPMean", "AIPMean", and "SWLSPMean" variables through the descriptive report function and binds them together into one data frame. 

* **dfHDI** - A data frame that lists all countries, their associated HDI score, and HDI category
* frequency_Table -A data frame to store the count of a participants by designated variable 
* GenderTable -Stores the frequency_Table output for the gender variable. 
* hdi_ls_mean
* **inBoth** - A list that contains the countries that were in both the top 15 GP and DP scores.
* Occupation_Table - Stores the frequency_Table output for the Occupation variable.
* ParticipantTable - Stores the frequency_Table output for the Participant variable.
* **Procrastination** - The primary data frame used for this analysis. It contains HDI data and survey results.
* **server** - Function that will manipulate the table based on the input from the slider bar. Used for shiny.
**income_age_data**- subset of Procrastination data set. Only includes age, gender, annual income and male indicator variables. This variable has a value of 1 if the participant is a male and 0 if they are not.
**income_age_model**- regression model using age to predict annual income.
**income_age_model2**- regression model using age and male indicator variable to predict annual income.
**ls_hdi_data**- subset of Procrastination data set. Only includes 2016_HDI_est, gender, SWLSPMean, and male indicator variable.
**ls_hdi_model**- regression model using life satisfaction (SWLSPMean) to predict HDI.
**ls_hdi_model2**- regression model using life satisfaction and male indicator variable to predict HDI.
**survery_means**- subset of Procrastination data set. Only includes DPMean, AIPMean, GPMean and SWLSPMean.

* **table1 to table8** - these are tables as they are scrapped off of Wikipedia.
* ui - An ui object to store the application's layout.
* **url** - Wikipedia url (https://en.Wikipedia.org/wiki/List_of_countries_by_Human_Development_Index)
* WorkStatusTable -Stores the frequency_Table output for the Participant variable


## Pulling Human Development Index Data from Wikipedia
A major part of this analysis was pulling Human Development Index data and incorporating it into 
the master data set. Since this is a fairly unique process the code used to pull the data from Wikipedia
is outlined below.

### Introduction to the Human Development Index
According to Wikipedia, the Human Development Index (HDI) is: 

".. a composite statistic of life expectancy, education, and income per capita indicators. A country scores higher HDI when the life
 expectancy at birth is longer, the education period is longer, and the income per capita is higher. It is used to distinguish whether the
 country is a developed, a developing or an underdeveloped country."

As such, it is a useful statistic when analyzing employee sentiment and procrastination scores by providing contextual information about
 the country in which an employee resides.

Wikipedia has tables with the HDI information for each country. This data was scrapped and incorporated into this analysis.


### Scrapping Process and Outputs
The wikipedia webpage that was used to collate this data was: https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index 

The primary library utilized to pull this data was rvest. Please note that some people have issues with some of the dependencies in rvest.
If problems are encountered when trying to run the R code to scrape the webpage please try re-installing the "selectr" package.

The tables that are pulled by the code are under the "Complete list of countries" section of the webpage. This is accomplished by looping
through the webpages and assigning them to their individual data frames and then stacking these data sets. The HDI_Category was created by
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

## Helper Functions

**Descriptive_report(variable)** - This function calculates the descriptive statics and puts it into a table
```{r}
Descriptive_report<-function(variable){
#Creats objects for caculations
Med.var<-median(variable,na.rm = TRUE)
Min.var<-min(variable,na.rm = TRUE)
Max.var<-max(variable,na.rm = TRUE)
Mean.var<-mean(variable,na.rm = TRUE)
SD.var<-sd(variable,na.rm = TRUE)
Range.var<-Max.var-Min.var

#Puts together objects into one DF and prits with rounding
Report<-data.frame(Min.var,Med.var,Max.var,Mean.var,SD.var,Range.var)
names(Report)<-c("Min","Median","Max","Mean","Standard Deviation","Range")
Report
}
```

**server(input, output, session)** - Function that will manipulate the table based on the input from the slider bar 
```{r}
server<-function(input,output,session){
  output$ShinyTable<- renderTable({
    radTable<-switch(input$radTable,
                     Occupation = Occupation_Table,
                     Country = CountryTable,
                     Gender = GenderTable,
                     'Work Status' = WorkStatusTable,
                     "Participant's views on Procrastination" = ParticipantTable,
                     'Descriptive statistics' = Descriptive_Table)
    
    updateSliderInput(session,"num",max = length(radTable[,1]))
    
    head(radTable,input$num)
    
  })
  
}
```

## Top 15 Countries by General Procrastination (GP) and Decisional Procrastination (DP) Scales 
The top 15 countries with the highest **mean** GP and DP scores were identified by aggregating the mean scores by Country and HDI_Category.
Once the top 15 countries were identified by each score, a simple bar chart was created to help visualize the data. There were 9 countries
that appeared in both analysis. These countries are:

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

**Top 15 Countries by DP and their location in the world**
![DP Image](https://raw.githubusercontent.com/khthomas/DDS_CS2/master/Code/dpmean.JPG)
![DP Map](https://raw.githubusercontent.com/khthomas/DDS_CS2/master/Code/dpmap.JPG)
**Top 15 Countries by GP and their location in the world**
![GP Image](https://raw.githubusercontent.com/khthomas/DDS_CS2/master/Code/gpmean.JPG)
![GP Image](https://raw.githubusercontent.com/khthomas/DDS_CS2/master/Code/gpmap.JPG)



## Frequently Asked Questions (FAQ)
Q1: I cannot scrape the Wikipedia webpage.

A1: Some people may have a bad installation of the selectr package. Please try re-installing this package (install.packages("selectr"))

Q2: My column names are all messed up? What is happening?

A2: We think this issue is due to different the different R Environments of the analysts. The difference comes from how the R environment treats spaces (" "). Try the following:
```{r}
 colnames(Procrastination) = gsub("\\.","", colnames(Procrastination))
```

Q3: Column names are still nonsense. Anything else?

A3: One last issue. Try running the following code instead of the code listed on lines 107-113:
```{r}
for(i in 15:59)
{
ProColNames[i]<-substr(ProColNames[i],2,which(strsplit(ProColNames[i],"")[[1]] == ")" )-1)
}
```
Q4: I have more Questions? Who can I talk to?

A4: Please reach out to one of our analysts:
* **Matt Rega** - mrega@smu.edu
* **Steven Hayden** - skhayden@smu.edu
* **Kyle Thomas** - khthomas@smu.edu



