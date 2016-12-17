plot3 <- function(){
    #capture local (script) directory 
    #all data files will be created here
    s_Script_Dir <- getSrcDirectory(eval(match.call()[[1]]))
    
    #load data script
    source(file.path(s_Script_Dir, "datalib.R"))
    
    #initiate windows device
    windows()
    
    #get plot data as data.frame
    plot_data <- getDataForPlot()

    #initialize the plot with Sub_metering_3 
    plot(plot_data$Sub_metering_3 ~ plot_data$DateTime, type = "l", col = "blue", xlab = "", ylab = "Energy dub metering", ylim = c(1, 30))
    
    #then add plots for Sub_metering_2 and Sub_metering_3
    lines(plot_data$Sub_metering_2 ~ plot_data$DateTime, col = "red")
    lines(plot_data$Sub_metering_1 ~ plot_data$DateTime, col = "black")
    
    #create a legend in the upper right corner
    legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
    
    #copy plot from window to png device
    dev.copy(png, filename = file.path(s_Script_Dir, "plot3.png"), width = 480, height = 480)
    
    #release PNG device and store the file
    dev.off(dev.prev())
    dev.off()
}