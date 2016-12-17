plot2 <- function(){
    #capture local (script) directory 
    #all data files will be created here
    s_Script_Dir <- getSrcDirectory(eval(match.call()[[1]]))
    
    #load data script
    source(file.path(s_Script_Dir, "datalib.R"))
    
    plot_data <- getDataForPlot()
    
    png(filename = file.path(s_Script_Dir, "plot2.png"), width = 480, height = 480)
    
    plot(plot_data$Global_active_power ~ plot_data$DateTime, type = "l", xlab = "", ylab = "Gloval Active Power (kilowatts)")
    
    dev.off()
}