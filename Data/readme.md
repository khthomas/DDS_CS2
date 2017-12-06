# Data Directory

This directory contains all of the data used in the Procrastination analysis conducted for  Waterfront Data Corp.

In addition, several data sets were created as a result of this analysis and are included here as well.

## Description of Data Sets
**Procrastination.csv** - This data set contains the raw data set from the study done by Qualtrics. This data set needed
some cleaning and processing. This process is well document in the RMarkdown (.rmd file) provided in the _"Code"_ repository.

**Count_by_Country_list.csv** - This data set contains the number of participants from each country that participate
**Count_by_Country_list.csv** - This data set contains the number of participants from each country that participated in the survey.

**count_by_Occupation_list.csv** - This data set contains the count of each occupation listed in the survey.

**Clean_Procrastination_Table.csv** - The procrastination data set after it has been processed and merged with new data sets.

**HDI_Table.csv** - This CSV contains All countries, their 2016 estimated HDI value, and their associated HDI category

**Top15MostProcrastinatingCountries_DPMean.csv** - The top 15 countries with the highest mean Decisional Procrastination (DP) Score, 
their associated HDI category, their 2016 estimated HDI score, and the mean DP value.

**Top15MostProcrastinatingCountries_GPMean.csv** - The top 15 countries with the highest mean General Procrastination (GP) Score, 
their associated HDI category, their 2016 estimated HDI score, and the mean GP value.

## Description of Variables in Procrastination.csv

**Country**- The country where the participant is from

**Age**- The age of the participant

**Gender**- The gender of the participant

**Kids**- Whether the participant has children (Yes kids or no kids)

**Edu**- The education level of the participant

**WorkStatus**- The participant’s work status

**AnnualIncome**- The participant’s annual income in US dollars

**Occupation**- The participant’s occupation

**TenureYears**- How many years the participant has held their current job

**TenureMonths**- How many months the participant has held their current job

**MaritalStat**- Participant’s marital status

**Sons**- Number of sons the participant has

**Daughters**- Number of daughters the participant has

**DP1**- I waste a lot of time on trivial matters before getting to the final decisions

**DP2**- Even after I make a decision I delay acting upon it

**DP3**- I don’t make decisions unless I really have to

**DP4**- I delay making decisions until it’s too late

**DP5**- I put off making decisions until it’s too late

**AIP1**- I pay my bills on time

**AIP2**- I am prompt and on time for most appointments.

**AIP3**- I lay out my clothes the night before I have an important appointment, so I won’t be late

**AIP4**- I find myself running later than I would like to be

**AIP5**- I don’t get things done on time

**AIP6**- If someone were teaching a course on how to get things done on time, I would attend

**AIP7**- My friends and family think I wait until the last minute.

**AIP8**- I get important things done with time to spare

**AIP9**- I am not very good at meeting deadlines

**AIP10**- I find myself running out of time.

**AIP11**- I schedule doctor’s appointments when I am supposed to without delay

**AIP12**- I am more punctual than most people I know

**AIP13**- I do routine maintenance (e.g., changing the car oil) on things I own as often as I should

**AIP14**- When I have to be somewhere at a certain time my friends expect me to run a bit late

**AIP15**- Putting things off till the last minute has cost me money in the past

**GP1**- I often find myself performing tasks that I had intended to do days before

**GP2**- I often miss concerts, sporting events, or the like because I don’t get around to buying tickets on time

**GP3**- When planning a party, I make the necessary arrangements well in advance

**GP4**- When it is time to get up in the morning, I most often get right out of bed

**GP5**- A letter may sit for days after I write it before mailing it possible

**GP6**- I generally return phone calls promptly

**GP7**- Even jobs that require little else except sitting down and doing them, I find that they seldom get done for days

**GP8**- I usually make decisions as soon as possible

**GP9**- I generally delay before starting on work I have to do

**GP10**- When traveling, I usually have to rush in preparing to arrive at the airport or station at the appropriate time

**GP11**- When preparing to go out, I am seldom caught having to do something at the last minute

**GP12**- In preparation for some deadlines, I often waste time by doing other things

**GP13**- If a bill for a small amount comes, I pay it right away

**GP14**- I usually return a “RSVP” request very shortly after receiving it

**GP15**- I often have a task finished sooner than necessary

**GP16**- I always seem to end up shopping for birthday gifts at the last minute

**GP17**- I usually buy even an essential item at the last minute

**GP18**- I usually accomplish all the things I plan to do in a day

**GP19**- I am continually saying “I’ll do it tomorrow”

**GP20**- I usually take care of all the tasks I have to do before I settle down and relax for the evening

**SWLS1**- In most ways my life is close to my ideal

**SWLS2**- The conditions of my life are excellent

**SWLS3**- I am satisfied with my life.

**SWLS4**- So far I have gotten the important things I want in life

**SWLS5**- If I could live my life over, I would change almost nothing

**YouConsider**- Do you consider yourself a procrastinator?

**OtherConsider**- Do others consider you a procrastinator?

**DPMean**- Average of the participant’s answers to the Decisional Procrastination Scale (DP) (Mann, 1982)

**AIPMean**- Average of the participant’s answers to the Adult Inventory of Procrastination (AIP) (McCown & Johnson, 1989)

**GPMean**- Average of the participant’s answers to the General Procrastination Scale (GP) (Lay, 1986)

**SWLSPMean**- Average of the participant’s answers to the Satisfaction with Life Scale (SWLSP) (Diener et al., 1985)

**2016_Est_HDI**- The estimate of Human Development Index for 2016 for the country where the participant is from

**HDI_Category**- The Human Development Index category the country the participant is from is in. Categories are low (0.549-0), medium (0.699-0.550), high (0.799-0.700), very high (1.000-0.800).

All DP, AIP, GP, SWLSP questions are answered on a scale of 1 (strongly disagree) to 5 (strongly agree).


If there are any questions about this data set please reach out to one of our analysts:

* **Matt Rega** - mrega@smu.edu
* **Steven Hayden** - skhayden@smu.edu
* **Kyle Thomas** - khthomas@smu.edu
