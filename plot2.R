plot2 <- function(){
    #capture local (script) directory 
    #all data files will be created here
    s_Script_Dir <- getSrcDirectory(eval(match.call()[[1]]))
    
    #load data script
    source(file.path(s_Script_Dir, "datalib.R"))
    
    #get plot data as data.frame
    plot_data <- getDataForPlot()
    
    #initialize PNP device
    png(filename = file.path(s_Script_Dir, "plot2.png"), width = 480, height = 480)
    
    #create a line plot
    plot(plot_data$Global_active_power ~ plot_data$DateTime, type = "l", xlab = "", ylab = "Gloval Active Power (kilowatts)")
    
    #release PNG device and store the file
    dev.off()
}