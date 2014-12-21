
rm(list=ls())
# Read the Training Data
tr<-read.table(file="X_train.txt", header = FALSE, sep = "")

# Read Training labels
tr_labels<-read.table(file="y_train.txt", header = FALSE, sep = "\n")


# Read subject info
tr_subj<-read.table(file="subject_train.txt", header = FALSE, sep = "\n")

# Read list of variables name
var<-read.table(file="features.txt", header = FALSE, sep = "\n")

# Remove numbers
var1<-gsub("\\d","",var$V1)

#var2<-gsub("^[0-9]","",var$V1) # var2 is a char vector
var2<-gsub("\\(\\)","",var1) 

# There are " -," at the end of few variables, let's remove them
var3<-gsub("-,$","",var2) # ok
# There are empty space at the begining of each variables, let us
# remove them
var4<-gsub("^ ","",var3) #ok
# There are ",", remove them
var5<-gsub(",","",var4) # ok
# Remove "("
var6<-gsub("\\(","",var5) # ok

# Remove ")"
var7<-gsub("\\)","",var6) # ok
# Make "-" into underscore sign
var8<-gsub("-","_",var7) # ok


# enter subject and Training labels with the data
tr2<-cbind(tr_subj,tr_labels,tr);

# Change the first two columns name
colN<-colnames(tr2)
colN[1:2]<-c('Subject','Activity')


# Insert the variables names
colN[3:563]<-var8

colnames(tr2)<-colN

# Read in test data

ts<-read.table(file="X_test.txt", header = FALSE, sep = "")

# Read Training labels
ts_labels<-read.table(file="y_test.txt", header = FALSE, sep = "\n")

# Read subject info
ts_subj<-read.table(file="subject_test.txt", header = FALSE, sep = "\n")


# enter subject and Training labels with the data
ts2<-cbind(ts_subj,ts_labels,ts);

# Change the first two columns name
colN<-colnames(ts2)
colN[1:2]<-c('Subject','Activity')


# Insert the variables names
colN[3:563]<-var8

colnames(ts2)<-colN

# Merge tr2 and ts2
MrgData <- rbind(tr2,ts2) 

# Let us Uses descriptive activity names to name the 
# activities in the data set
MrgData$Activity[MrgData$Activity==1]<-'WALKING'
MrgData$Activity[MrgData$Activity==2]<-'WALKING_UPSTAIRS'
MrgData$Activity[MrgData$Activity==3]<-'WALKING_DOWNSTAIRS'
MrgData$Activity[MrgData$Activity==4]<-'SITTING'
MrgData$Activity[MrgData$Activity==5]<-'STANDING'
MrgData$Activity[MrgData$Activity==6]<-'LAYING'

# In order to extract thos variables with "mean" or "Mean"
# and "sd" or "SD" in them
#grep('mean',colnames(MrgData))
grep('[Mm]ean',colnames(MrgData))

grep('[Ss]td',colnames(MrgData))

# Let us create a subset of MrgData using above mean and std
# variables + Subject and Activity variables

indU<-union(grep('[Mm]ean',colnames(MrgData)),grep('[Ss]td',colnames(MrgData)))

Sub_MrgData<-MrgData[,c(1,2,indU)]

# Project Step 5: From the data set in step 4, creates a second, 
# independent tidy data set with the average of each 
# variable for each activity and each subject.


# There are 30 subjects. Now we partition the Sub_MrgData
# for each subjects; let us do it in a loop

for (i in 1:30) { 
  nam <- paste("tst", i, sep = "")
  assign(nam, Sub_MrgData[Sub_MrgData$Subject==i,])
}

dflist <- c("tst1", "tst2", "tst3", "tst4","tst5",
            "tst6", "tst7", "tst8", "tst9","tst10",
            "tst11", "tst12", "tst13", "tst14","tst15",
            "tst16", "tst17", "tst18", "tst19","tst20",
            "tst21", "tst22", "tst23", "tst24","tst25",
            "tst26", "tst27", "tst28", "tst29","tst30")

for (i in dflist) {
nam2 <- paste("out_",i, sep="")
assign(nam2,aggregate(eval(parse(text=i))[, 4:88],
    by=list(eval(parse(text=i))$Subject,eval(parse(text=i))$Activity), mean))
}


out_files<-c("out_tst1","out_tst2","out_tst3","out_tst4",
             "out_tst5","out_tst6","out_tst7","out_tst8",
             "out_tst9","out_tst10","out_tst11","out_tst12",
             "out_tst13","out_tst14","out_tst15","out_tst16",
             "out_tst17","out_tst18","out_tst19","out_tst20",
             "out_tst21","out_tst22","out_tst23","out_tst24",
             "out_tst25","out_tst26","out_tst27","out_tst28",
             "out_tst29","out_tst30")
# change the 1st and 2nd variable names to Subject and 'Activity' for all
# the 30 output files by using

names(out_tst1)[1:2]<-c('Subject','Activity')
names(out_tst2)[1:2]<-c('Subject','Activity')
names(out_tst3)[1:2]<-c('Subject','Activity')

names(out_tst4)[1:2]<-c('Subject','Activity')
names(out_tst5)[1:2]<-c('Subject','Activity')
names(out_tst6)[1:2]<-c('Subject','Activity')

names(out_tst7)[1:2]<-c('Subject','Activity')
names(out_tst8)[1:2]<-c('Subject','Activity')
names(out_tst9)[1:2]<-c('Subject','Activity')

names(out_tst10)[1:2]<-c('Subject','Activity')
names(out_tst11)[1:2]<-c('Subject','Activity')
names(out_tst12)[1:2]<-c('Subject','Activity')

names(out_tst13)[1:2]<-c('Subject','Activity')
names(out_tst14)[1:2]<-c('Subject','Activity')
names(out_tst15)[1:2]<-c('Subject','Activity')
names(out_tst16)[1:2]<-c('Subject','Activity')
names(out_tst17)[1:2]<-c('Subject','Activity')
names(out_tst18)[1:2]<-c('Subject','Activity')
names(out_tst19)[1:2]<-c('Subject','Activity')
names(out_tst20)[1:2]<-c('Subject','Activity')
names(out_tst21)[1:2]<-c('Subject','Activity')
names(out_tst22)[1:2]<-c('Subject','Activity')
names(out_tst23)[1:2]<-c('Subject','Activity')
names(out_tst24)[1:2]<-c('Subject','Activity')
names(out_tst25)[1:2]<-c('Subject','Activity')
names(out_tst26)[1:2]<-c('Subject','Activity')
names(out_tst27)[1:2]<-c('Subject','Activity')
names(out_tst28)[1:2]<-c('Subject','Activity')
names(out_tst29)[1:2]<-c('Subject','Activity')
names(out_tst30)[1:2]<-c('Subject','Activity')

# We use rbind to join all the output data
FinalData<-rbind(out_tst1,out_tst2,out_tst3,out_tst4,out_tst5,
                 out_tst6,out_tst7,out_tst8,out_tst9,out_tst10,
                 out_tst11,out_tst12,out_tst13,out_tst14,out_tst15,
                 out_tst16,out_tst17,out_tst18,out_tst19,out_tst20,
                 out_tst21,out_tst22,out_tst23,out_tst24,out_tst25,
                 out_tst26,out_tst27,out_tst28,out_tst29,out_tst30)

# Let us change/give more meaning full variables/columns names 

clnn<-names(FinalData)
clnn2<-clnn[3:87]
clnn3<-gsub("^t|^f|^a","MeanOf_", clnn2)
names(FinalData)[3:87]<-clnn3

# Let us use the following write command to save our final, tidy
# data set
write.table(FinalData,file='FinalData.txt',row.names=FALSE)

# The saved tidy data file can easily be read and viewed by using
# the following commands:
# test2<-read.table('FinalData.txt',header=T)
# View(test2)