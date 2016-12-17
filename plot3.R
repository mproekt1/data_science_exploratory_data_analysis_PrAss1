plot3 <- function(){
    #capture local (script) directory 
    #all data files will be created here
    s_Script_Dir <- getSrcDirectory(eval(match.call()[[1]]))
    
    #load data script
    source(file.path(s_Script_Dir, "datalib.R"))
    
    plot_data <- getDataForPlot()
    
    png(filename = file.path(s_Script_Dir, "plot3.png"), width = 480, height = 480)
    
    plot(plot_data$Sub_metering_3 ~ plot_data$DateTime, type = "l", col = "blue", xlab = "", ylab = "Energy dub metering", ylim = c(1, 30))
    lines(plot_data$Sub_metering_2 ~ plot_data$DateTime, col = "red")
    lines(plot_data$Sub_metering_1 ~ plot_data$DateTime, col = "black")
    
    legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
    
    dev.off()
}