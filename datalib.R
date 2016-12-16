getDataForPlot <- function(){
    # This function returns subset of Electric power consumtion (EPC) data that includes
    # only dates 2007-02-01 and 2007-02-02
    
    # This function will also store the subsetted data in a local file for the future use
    
    # 1. Check if a file with subsetted EPC data already exists
    # 2. If the file does not exist, then download the file, unzip, read into table, subset, 
    #    store in a local file, and return subset as data.frame
    # 3. If the subset file exists, then read from the subset file and return as data.frame
    
    #capture local (script) directory 
    #all data files will be created here
    s_Script_Dir <- getSrcDirectory(eval(match.call()[[1]]))
    
    #data file URL
    s_EPC_archive_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    #name of the data file in archive
    s_EPC_archive_file <- "household_power_consumption.txt"
    
    #name of the subsetted data file stored locally
    s_EPC_subset_file <- "household_power_consumption_subset.txt"
    
    s_EPC_subset_path <- file.path(s_Script_Dir, s_EPC_subset_file)
    
    #does the subsetfile exist
    if(!file.exists(s_EPC_subset_path)){
        #create a file to temporary store downloaded file
        s_temp_EPC_file <- tempfile()

        #download data file into temp file
        download.file(s_EPC_archive_URL, s_temp_EPC_file)
        
        #create data.frame from the file and subset to include only 2007-02-01 and 2007-02-02 dates
        write.table(subset(read.table(unz(s_temp_EPC_file, s_EPC_archive_file), sep = ";", header = TRUE), Date %in% c("2/1/2007", "2/2/2007")), file = s_EPC_subset_path, sep = ";")

        #release the temp file
        unlink(s_temp_EPC_file)
    }
    
    #read the local subsetted file
    return_data <- read.table(file = s_EPC_subset_path, header = TRUE, sep = ";")

    return_data
}