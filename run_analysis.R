## Function "run_analysis
##
## Input:
##      workDir - working directory, where "UCI HAR Dataset" data set 
#                   folder is located.
## Output:
##      run_analysis - independent tidy data set
run_analysis <- function(workDir) {
    library(dplyr)
    setwd(paste(workDir, "UCI HAR Dataset/", sep = ""))        # change working directory
    
    # feature label #
    feature_label <- read.csv2("features.txt", sep = "", header = FALSE 
                               , colClasses = "character")
    feature_label <- feature_label[2]
    
    # activity label #
    activity_label <- read.csv2("activity_labels.txt", sep = "", header = FALSE
                                , colClasses = "character")
    activity_label <- activity_label[2]
    
    ## read raw data set ##
    # "train" data set #
    xtrain <- read.csv2("./train/X_train.txt", sep = "", header = FALSE 
                        , colClasses = "character")
    ytrain <- read.csv2("./train/y_train.txt", sep = "", header = FALSE 
                        , colClasses = "character")
    strain <- read.csv2("./train/subject_train.txt", sep = "", header = FALSE 
                        , colClasses = "character")
    
    # "test" data set #
    xtest <- read.csv2("./test/X_test.txt", sep = "", header = FALSE 
                       , colClasses = "character")
    ytest <- read.csv2("./test/y_test.txt", sep = "", header = FALSE 
                       , colClasses = "character")
    stest <- read.csv2("./test/subject_test.txt", sep = "", header = FALSE 
                       , colClasses = "character")
    
    ## check feature index to collect ##
    mean_feature_index <- grepl(".mean.", feature_label[[1]])    # index of "mean" feature
    std_feature_index <- grepl(".std.", feature_label[[1]])      # index of "std" feature
    
    ## combine data set ##
    # from train #
    temp1 <- cbind(data.matrix(xtrain[mean_feature_index]),
                   data.matrix(xtrain[std_feature_index]))
    temp1 <- data.frame(temp1)
    act_conv <- sapply(ytrain, function(x) x <- activity_label[x,1])
    temp1["act"] <- as.vector(act_conv)
    temp1["subj"] <- as.vector(data.matrix(strain))
    
    # from test #
    temp2 <- cbind(data.matrix(xtest[mean_feature_index]),
                   data.matrix(xtest[std_feature_index]))
    temp2 <- data.frame(temp2)
    act_conv <- sapply(ytest, function(x) x <- activity_label[x,1])
    temp2["act"] <- as.vector(act_conv)
    temp2["subj"] <- as.vector(data.matrix(stest))
    
    # resulted combine data sets #
    combine_data <- merge(temp1, temp2, all = TRUE)
    
    # labeling columns #
    label_temp <- c(as.character(feature_label[mean_feature_index,1]), 
                    as.character(feature_label[std_feature_index,1]), 
                    "activity", "subject_no")
    colnames(combine_data) <- label_temp
    
    ## compute average data set ##
    act_vector <- activity_label[[1]]
    avg_data_n = NULL
    avg_data_act = NULL
    avg_data_subj = NULL
    for (act in act_vector) {
        for (subj in 1:30) {
            fdata <- filter(combine_data, combine_data$activity == act 
                   & combine_data$subject_no == subj)  
            act
            subj
            if (nrow(fdata) > 0) {
                temp <- colMeans((fdata[1:79]))
                avg_data_n <- rbind(avg_data_n, as.vector(temp))
                avg_data_act <- c(avg_data_act, act)
                avg_data_subj <- c(avg_data_subj, subj)
            }
        }
    }
    avg_data <- data.frame(avg_data_n)
    avg_data["activity"] <- avg_data_act
    avg_data["subject_no"] <- avg_data_subj
    colnames(avg_data) <- label_temp
    
    NewDataSet <- list(CombinedData = combine_data, AvgData = avg_data)
    
    ## export resulted data set ##
    # combined data set #
    write.csv(rrr$CombinedData, "combinedDataSet.csv", row.names = FALSE)
    
    # average data set #
    write.csv(rrr$AvgData, "averageDataSet.csv", row.names = FALSE)
    
    return (NewDataSet)
    
}