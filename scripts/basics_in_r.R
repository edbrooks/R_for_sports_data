#### THE BASICS IN R ####

#Assigning a value to a name in R - the '<-' symbol is an assignment operator
a <- 1

#Print the value using the name
a

#Alternatively print the value using the print function
print(a)

#Check the class of the object
class(a)

#Create an integer value of 1
a <- 1L

#Print the value using the name
a

#Check the class of the object
class(a)

#Create a character value using text
a <- "text"

#Print the value using the name
a

class(a)

#Create a vector of values
vector_a <- c(1,2,3,4,5)

#Print the vector
vector_a

#Calculate the mean of the vector
mean(vector_a)

#Calculate the sum of the vector
sum(vector_a)

#Generate a summary of the vector
summary(vector_a)

#Create a second vector
vector_b <- c(6,7,8,9,10)

#Calculate the mean of the vector
mean(vector_b)

#Calculate the sum of the vector
sum(vector_b)

#Add the vectors together - is this what you expected?
vector_a + vector_b

#Create a dataframe containing both of your vectors
dataframe <- data.frame(vector_a, vector_b)

#Print the dataframe to see the structure of the dataframe
dataframe

