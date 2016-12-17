getDataForPlot <- function(reload = FALSE,
                           filter_dates = c("2007-02-01", "2007-02-02")){
    # This function returns subset of Electric power consumtion (EPC) data that includes
    # only dates 2007-02-01 and 2007-02-02
    # the file stores date as d/m/yyyy
    
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
    if(!file.exists(s_EPC_subset_path) || reload){
        #create a file to temporary store downloaded file
        s_temp_EPC_file <- tempfile()

        #download data file into temp file
        download.file(s_EPC_archive_URL, s_temp_EPC_file)
        
        #create data.frame from the file
        raw_data <- read.table(unz(s_temp_EPC_file, s_EPC_archive_file), sep = ";", header = TRUE)

        #release the temp file
        unlink(s_temp_EPC_file)

        # apply date filter
        if(length(filter_dates) > 0){
            raw_data <- subset(raw_data, as.Date(Date, format = "%d/%m/%Y") %in% as.Date(filter_dates))
        }
        
        #save data in  filw in local directory
        write.table(raw_data, file = s_EPC_subset_path, sep = ";", row.names = FALSE)
    }
    
    #read the local subsetted file
    data <- read.table(file = s_EPC_subset_path, header = TRUE, sep = ";")

    #Merge Date and Time columns into POSIXct DateTime column and append remaining columns
    return_data <- data.frame(DateTime = as.POSIXct(paste(data$Date, data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"),
                              Global_active_power = data$Global_active_power,
                              Global_reactive_power = data$Global_reactive_power,
                              Voltage = data$Voltage,
                              Global_intensity = data$Global_intensity,
                              Sub_metering_1 = data$Sub_metering_1,
                              Sub_metering_2 = data$Sub_metering_2,
                              Sub_metering_3 = data$Sub_metering_3)

    return_data
}