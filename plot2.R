plot2 <- function(){
    #capture local (script) directory 
    #all data files will be created here
    s_Script_Dir <- getSrcDirectory(eval(match.call()[[1]]))
    
    #load data script
    source(file.path(s_Script_Dir, "datalib.R"))
    
    #initiate windows device
    windows()
    
    #get plot data as data.frame
    plot_data <- getDataForPlot()
    
    #create a line plot
    plot(plot_data$Global_active_power ~ plot_data$DateTime, type = "l", xlab = "", ylab = "Gloval Active Power (kilowatts)")
    
    #copy plot from window to png device
    dev.copy(png, filename = file.path(s_Script_Dir, "plot2.png"), width = 480, height = 480)
    
    #release PNG device and store the file
    dev.off(dev.prev())
    dev.off()
}