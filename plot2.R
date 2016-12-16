plot2 <- function(){
    #capture local (script) directory 
    #all data files will be created here
    s_Script_Dir <- getSrcDirectory(eval(match.call()[[1]]))
    
    #load data script
    source(file.path(s_Script_Dir, "datalib.R"))
    
    plot(getDataForPlot()$DateTime, getDataForPlot()$Global_active_power, type = "l")
}