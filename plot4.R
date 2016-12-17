plot4 <- function(){
    #capture local (script) directory 
    #all data files will be created here
    s_Script_Dir <- getSrcDirectory(eval(match.call()[[1]]))
    
    #load data script
    source(file.path(s_Script_Dir, "datalib.R"))
    
    #initiate windows device
    windows()
    
    #get plot data as data.frame
    plot_data <- getDataForPlot()

    #set plot area as 2x2
    par(mfrow = c(2, 2))
    
    #create first plot in the upper left corner
    plot(plot_data$Global_active_power ~ plot_data$DateTime, type = "l", xlab = "", ylab = "Gloval Active Power")

    #create second plot in the upper right corner
    plot(plot_data$Voltage ~ plot_data$DateTime, type = "l", xlab = "datetime", ylab = "Voltage")
    
    #create third plot in the lower left corner
    plot(plot_data$Sub_metering_3 ~ plot_data$DateTime, type = "l", col = "blue", xlab = "", ylab = "Energy sub metering", ylim = c(1, 30))
    lines(plot_data$Sub_metering_2 ~ plot_data$DateTime, col = "red")
    lines(plot_data$Sub_metering_1 ~ plot_data$DateTime, col = "black")
    
    legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), bty = "n")
    
    #create third plot in the lower right corner
    plot(plot_data$Global_reactive_power ~ plot_data$DateTime, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
    
    #copy plot from window to png device
    dev.copy(png, filename = file.path(s_Script_Dir, "plot4.png"), width = 480, height = 480)
    
    #release PNG device and store the file
    dev.off(dev.prev())
    dev.off()
}