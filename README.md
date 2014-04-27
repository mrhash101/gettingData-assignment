##This is the read me file for Getting and Cleaning Data course on Coursera Data Science Specialization

gettingData-assignment
======================
Acquiring Data:

Contents of 'X_train' and 'X_test' files were manually copied into new files by the name of 'X_train_mod' and 'X_test_mod'.

'X_train_mod' and 'X_test_mod' were read into dataframes. 

Adding column names:
=================
features.txt was read in a vector. 
colnames() function was used to add column names to different data frames


Retrieving specific Columns from Main dataframes:
================================
grep() function was used to identify column names and fetch data from those columns. 

Functions:
================
tidydata() accepts a dataframe as input and creates the tidyset.txt

replacenames() accepts two dataframes as input. First is the fulldata frame and the other is a list of labels. It replaces contents of the activity column according to the list of labels. 


Final output:
=============
tidyset.txt is a comma separated file with the tidy data-set of means of all variables at subjects/all activities


##Acknowledgement
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
