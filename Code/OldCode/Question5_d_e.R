library(ggplot2)

#scatterplot income vs age
ggplot(subset(Procrastination,!is.na(AnnualIncome)&!is.na(Age)&!is.na(Gender)),aes(x=Age,y=AnnualIncome,shape=Gender,color=Gender))+geom_point()+xlab("Age")+ylab("Annual Income in Dollars")+ggtitle("Annual Income vs Age")+theme(plot.title = element_text(hjust=0.5))

#create smaller data set for regression model
income_age_data<-data.frame(Procrastination$Age,Procrastination$Gender,Procrastination$AnnualIncome)
names(income_age_data)<-c("Age","Gender","Income")
income_age_data$male<-ifelse(income_age_data$Gender=="Male",1,0)

#correlation of age and income
cor.test(Procrastination$Age,Procrastination$AnnualIncome,method="pearson",use = "complete.obs")

#create linear regression model using just age then age and gender to predict income
income_age_model<-lm(Income~Age,data=income_age_data)
summary(income_age_model)
income_age_model2<-lm(Income~male+Age,data=income_age_data)
summary(income_age_model2)


#scatterplot life satisfaction vs hdi
ggplot(Procrastination,aes(x=Procrastination$`2016_Est_HDI`,y=SWLSPMean,shape=Gender,color=Gender))+geom_point()+xlab("Human Development Rating")+ylab("Life Statisfaction Rating (1-5(Highest))")+ggtitle("Life Statisfaction vs Human Development Rating")+theme(plot.title = element_text(hjust=0.5))

#create smaller data set for regression model
ls_hdi_data<-data.frame(as.numeric(Procrastination$`2016_Est_HDI`),Procrastination$Gender,Procrastination$SWLSPMean)
names(ls_hdi_data)<-c("HDI","Gender","Life_Satisfaction")
ls_hdi_data$male<-ifelse(ls_hdi_data$Gender=="Male",1,0)

#correlation of hdi and life statisfaction
cor.test(as.numeric(Procrastination$`2016_Est_HDI`),Procrastination$SWLSPMean,method="pearson",use = "complete.obs")

#create linear regression model using just HDI then HDI and gender to predict life statisfaction
ls_hdi_model<-lm(Life_Satisfaction~HDI,data=ls_hdi_data)
summary(ls_hdi_model)
ls_hdi_model2<-lm(Life_Satisfaction~HDI+male,data=ls_hdi_data)
summary(ls_hdi_model2)

#Create a barplot of life statisfaction and hid category
ggplot(Procrastination,aes(x=reorder(row.names(Procrastination),Procrastination$SWLSPMean),y=Procrastination$SWLSPMean,fill=Procrastination$HDI_Category))+geom_point()

hdi_ls_mean<-aggregate(Procrastination$SWLSPMean,list(Procrastination$HDI_Category),mean)
names(hdi_ls_mean)<-c("Group","Mean_Life_Satisfaction")

ggplot(hdi_ls_mean,aes(x=reorder(Group,Mean_Life_Statisfaction),y=Mean_Life_Statisfaction))+geom_bar(stat="identity",fill="#009E73")+ggtitle("Mean Life Satisfaction by HDI Category")+theme(plot.title = element_text(hjust=0.5))+xlab("HDI Category")+ylab("Mean Life Satisfaction")



