#############################################################################################################
#
#  This is course project for course "Getting and Cleaning Data" https://www.coursera.org/course/getdata
#
#  Code in this file should create tidy dataset from Samsung smartphone accelerometers data
#
#  processData function load RAW data, process it and save tidy data into file tidy.txt
#
#  Code written by Nadezda Strikovskaya
#  GitHub account: https://github.com/bagiran/
#
#
#############################################################################################################

library(plyr)

# Specify global constants for data
g.dataDir <- "./data/UCI HAR Dataset/"

# create path for file in specified category

buildFileName <- function( name, cat ) {
        paste( g.dataDir, cat, "/", name, "_", cat, ".txt", sep = "" )
}

# read data from category folder

readDataFromCat <- function( cat ) {
        
        activityLabels <- read.table( paste( g.dataDir, "activity_labels.txt", sep = "" ), header = FALSE, sep = " " )[, 2]
        
        featuresLabels <- read.table( paste( g.dataDir, "features.txt", sep = "" ), header = FALSE, 
                                      sep = " ", colClasses = c( "numeric", "character" ) ) [, 2]
        
        data <- read.table( buildFileName( "X", cat ), header = FALSE, 
                            col.names = featuresLabels, colClasses = "numeric" )
               
        activity <- read.table( buildFileName( "Y", cat ), 
                                header = FALSE, col.names = "Activity" )
        
        # add activity info into data set
        data <- cbind( activity, data )
        data$Activity <- as.factor( data$Activity )
        levels( data$Activity ) <- activityLabels
        
        #load subject data and add it into data set
        subject <- read.table( buildFileName( "subject", cat ), 
                               header = FALSE, col.names = "Subject" )
        
        data <- cbind( subject, data )
        
        data
}

# load raw data from project files

loadData <- function() {
        
        # check data existance and load if RAW Data missing
        if ( !file.exists( g.dataDir ) ) {
                dir.create( "./data", showWarnings = FALSE )
                
                if ( !file.exists( "./data/data.zip" ) )
                        download.file( "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                                       "./data/data.zip" )
                
                unzip( "./data/data.zip", exdir="./data" )
        }
        
        merge( readDataFromCat( "test" ), readDataFromCat( "train" ), all = TRUE, sort = FALSE )
}

# create tidy data from raw data and save result in file tidy.txt
processData <- function() {
        data <- loadData()
        
        # use only mean and standard deviation data from this set
        data <- data[, grep( "Activity|Subject|mean\\.|std\\.", colnames(data) ) ]       
        
        colnames(data) <- sub("\\.\\.", "", colnames(data) )
        
        # colMeans can't deal with factor, so store factor as int
        
        labels <- levels( data$Activity )
        data$Activity <- as.integer( data$Activity )
        
        # find mean variables
        tidy <- ddply( data, .( Subject, Activity ), colMeans )
        
        # restore factor
        tidy$Activity <- as.factor( tidy$Activity )
        levels( tidy$Activity ) <- labels   

        # save result
        write.table( tidy, file = "tidy.txt", row.name = FALSE )
}
