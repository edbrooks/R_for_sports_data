#### NBA SPORTS DATA IN R ####

#Remove the '#' symbol at the beginning of the line to allow code to run 
#Don't remove the '#' if the line is for a comment (this allows r to skip over)


#Install the required packages if you have not used them before
install.packages("dplyr", #wrangle data using dplyr
                "ggplot2",#visualise/plot data using ggplot2
                "readr",#read in data
                "here") #here helps to organise projects in r - easily locate csv

#If you have previously installed these packages use library to load them
library("dplyr",
        "ggplot2",
        "readr",
        "here")

#Import the data into the environment
NBA <- readr::read_csv("data/NBA_2017-18_AdvancedStats_Salary.csv", col_names = TRUE)

#Use the summary function to explore the  dataframe (e.g., class, spread, etc.)
summary(NBA)

#Use the head function to see the first 6 rows of data
head(NBA)

#Use the tail function to see the bottom 6 rows of data
tail(NBA)

#How might we work out how many unique players or country names are in the data set
Countries <-unique(NBA$NBA_Country)

unique(NBA$NBA_Country)

#Use the filter function to filter the data to NBA_Country == "Australia"
NBA %>% filter(NBA_Country == "Australia")

#Store the new dataframe in the environment
aus_NBA <- NBA %>% filter(NBA_Country == "Australia")
               
#Check the class of the Salary data type - if it is not numeric (due to symbols or text, 
#then use the parse_number function)

class(NBA$Salary)

NBA$Salary <- parse_number(NBA$Salary)
               
# Use options(scipen=999) if showing scientific notations
options(scipen=999)
               
#Check that the data class has changed to numeric for Salary
class(NBA$Salary)
               
#Arrange the Salary data in a descending order to show highest at the top
highest_paid <- NBA %>% arrange(desc(Salary)) %>% select(Player, Salary)

#Check specific values in dataframe
NBA %>% filter(Player == "Blake Griffin")

#So, why does he appear in the data frame three times?
#He played for multiple teams in one year, but his Salary was an annual total
               
#Are the most minutes given to the highest paid players?

#Check the correlation between MP (minutes played) and Salary
cor(NBA$MP, NBA$Salary)
               
# A moderate-strong positive relationship exists between MP and Salary

#Create a subset of data using the filter function to eliminate any players who 
#didn't play many minutes during the season or had no/low allocated Salary
NBA_filtered <- NBA %>% filter(Salary >= 10000 & MP >= 25)
               
#Create a basic plot to show the relationship between MP and Salary
plot(NBA_filtered$MP, NBA_filtered$Salary)
               
#Create a ggplot to show the relationship between MP and Salary
ggplot <- ggplot(NBA_filtered, aes(x = MP, y = Salary), colour = Tm)
               
#Add some features (geom_point, facet, and reg line) and print/show the plot
#The facet splits the data/plots into teams
ggplot + geom_point() + facet_wrap('Tm') + geom_smooth(method = lm)
               
#Using the filtered data set, add a variable dividing the Salary/MP to get dollars per min (dpm)
NBA_filtered$dpm <- NBA_filtered$Salary/NBA_filtered$MP
               
#Check the top few players using the head, select, and arrange functions
head(NBA_filtered %>% select(Player, dpm) %>% arrange(desc(dpm)))
               
#Filter the data set to investigate the top Player for dpm 
#Is there a reason why he might be  the highest paid per minute?
NBA %>% filter(Player == "Jeremy Lin") %>% select(Player,Salary,G,MP)

#He only played one game (25 mins) and was paid $12M salary
                                       
#Create a variable for Salary/Player Efficiency Rating 
#PER is a broad measure including positive and negative stats to determine efficiency/value
NBA_filtered$dprate <- NBA_filtered$Salary/NBA_filtered$PER
                                       
#Use the as.numeric function to make the values numeric
NBA_filtered$PER <- as.numeric(NBA_filtered$PER)

#Create a ggplot using PER - Include a filter for Team (Tm)
ggplot <- ggplot(NBA_filtered %>% filter(Tm == "GSW"), aes(x = PER, y = PER, label = Player), colour = Pos)
                                       
#Print the plot with some additions
ggplot +
geom_point() +
geom_label(aes(fill = Pos))+
theme_classic() +
theme(axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank(),
      axis.title.y = element_text(size = 14, face = "bold")) +
labs(fill = "Position") +
xlim (c(0, 35)) + ylim(c(0,35))

#Create an alternative ggplot to assist with readability
ggplot <- ggplot(NBA_filtered %>% filter(Tm == "GSW") %>% arrange(desc(PER)), aes(x = Player, y = PER), colour = Pos)

ggplot +
  geom_col(aes(fill = Pos)) +
  theme_classic() +
  theme(axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  coord_flip()

#Create a new ggplot filtering all the players with a PER over 22 and at least 10 Games
ggplot <- ggplot(NBA_filtered %>% filter(PER > 23 & G > 20), aes(x = Player, y = PER, fill = Pos))

#Print the ggplot with extra features
ggplot +
  geom_col(aes(fill = Pos)) +
  theme_classic() +
  theme(axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)) +
  coord_flip()

#Highest player rating (PER)
NBA_filtered %>% filter(Player == "James Harden")


## Thanks to Meicher on Kaggle for the Public Dataset
## https://www.kaggle.com/meicher/201718-advanced-player-metrics-salary