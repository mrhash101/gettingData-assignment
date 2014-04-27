## This code cleans the provided Samsung data set as required. 
## Written by Hassan, Krakow, PL

##Reading files and loading into data frames

#Reading training and test files
traindf<- read.csv("UCI HAR Dataset/train/X_train_mod", sep = ",", header = FALSE) 
testdf<- read.csv("UCI HAR Dataset/test/X_test_mod", sep = ",", header = FALSE)

#Reading activity files and subject files
activity_train<- read.csv("UCI HAR Dataset/train/y_train.txt", sep = " ", header = FALSE) 
subject_train<- read.csv("UCI HAR Dataset/train/subject_train.txt", sep = " ", header = FALSE)

activity_test<- read.csv("UCI HAR Dataset/test/y_test.txt", sep = " ", header = FALSE) 
subject_test<- read.csv("UCI HAR Dataset/test/subject_test.txt", sep = " ", header = FALSE)

#Activity Labels
activity_labels<- read.csv("UCI HAR Dataset//activity_labels.txt", sep = " ", header = FALSE)
activity_labels[,2]<-as.character(activity_labels[,2])
  
#Reading the second column of features,txt only
features<- read.csv("UCI HAR Dataset//features.txt", sep = " ", header = FALSE)[,2]
features<- as.character(features)
features_full<- c("subjects", "activity", features)


##Merging columns from different data frames to create a new data frame - separately for train and test data-sets
complete_traindf<- data.frame(subject_train, activity_train, traindf)
complete_testdf<- data.frame(subject_test, activity_test, testdf)

#Creating one data-set from the training data-set and the test data-set
fulldata<- rbind(complete_traindf, complete_testdf)

##assigning names to columns
colnames(fulldata)<- features_full

##Extracts only the measurements on the mean and standard deviation for each measurement.

#creating indexes for mean, Mean, std values
x<- names(fulldata)
index_mean<- grep(c("mean"), x)
index_Mean<- grep(c("Mean"), x)
index_std<- grep(c("std"), x)

index_final<- sort(c(index_mean, index_Mean, index_std))


#extracting values for mean and std columns and storing into a new dataframe called mean_std_data
mean_std_data<- data.frame(fulldata[,c(1,2,index_final)])

#replacing activity names for this data-set
mean_std_data<- replacenames(mean_std_data, activity_labels)

#Function for replacing column values with a key - call function with a dataframe to be replaced and activity labels
replacenames<- function(fulldata, activity_labels){
  for(i in 1:length(fulldata[,"activity"])){
    for(j in 1:length(activity_labels[,1])){  
      if (fulldata[i,"activity"]==activity_labels[j,1]){
        fulldata[i,"activity"]<- activity_labels[j,2]
      }
    }
  }
  return(fulldata)
}

#calling function replacenames on fulldata - to replace activity names
fulldata<- replacenames(fulldata, activity_labels)


#Order fulldata by subjects
fulldata<- fulldata[order(fulldata$subjects, decreasing=FALSE),]


#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
avg_matrix<- data.frame()
avg_matrix2<- data.frame()
subject<- vector()
activity<- vector()
subject1<- vector()
activity1<- vector()

tidydata<- function(fulldata){
  for (i in 1:30){
    for (j in 1:6){
      
      #subset data based on one combination on subject and activity
      tempDF<- subset(fulldata, fulldata[,"subjects"]==i & fulldata[, "activity"]==j)
      
      #calculate avg of all variables and add that to avgDF
      m<- sapply(tempDF[,3:563], mean)
      m<- as.data.frame(m)
      
      #copying the values of m in avg_matrix
      for (l in 1:nrow(m)){
        avg_matrix[1,l]<- m[l,1]
      }
      avg_matrix2<- rbind(avg_matrix2, avg_matrix)
      
      subject<- tempDF[1,"subjects"]
      activity<- tempDF[1, "activity"]   
      subject1<- c(subject1, subject)
      activity1<- c(activity1, activity)
      
    }
  }
  final_mat<- cbind(subject1, activity1, avg_matrix2)
  colnames(final_mat)<- features_full
  final_mat<-replacenames(final_mat, activity_labels)
  return (final_mat)
  
  ##writing to files
  write.table(final_mat, file = "tidyset.txt", sep = ",")
}

#calling tidydata function for final part - result will be written to a file 'tidyset.txt'
tidydata(fulldata)





