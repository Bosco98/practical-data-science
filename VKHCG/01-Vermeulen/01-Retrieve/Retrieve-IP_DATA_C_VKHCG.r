###########################################
rm(list=ls()); #will remove ALL objects
###########################################
if (Sys.info()['sysname'] == "Windows") 
  {
    BaseSet = "C:/VKHCG"
    setwd(BaseSet)
  } else {
    BaseSet = paste0("/home/" , Sys.info()['user'] , "/VKHCG")
    setwd(BaseSet)
  }
###########################################
Base=getwd()
FileDir= paste0(Base,'/01-Vermeulen/01-Retrieve/01-EDS/01-R')
dir.create(FileDir)
FileDirLog=paste0(FileDir,'/log')
dir.create(FileDirLog) 
FileDirRun=paste0(FileDirLog,'/Run0002')
dir.create(FileDirRun)
###########################################
StartTime=Sys.time()
###########################################
# Set up logging
###########################################
debugLog=paste0(FileDirRun,'/debug.Log')
infoLog=paste0(FileDirRun,'/info.Log')
errorLog=paste0(FileDirRun,'/error.Log')
###########################################
write(paste0('Start Debug Log File ',
      format(StartTime, "%Y/%d/%m %H:%M:%S")),
      file=debugLog,append = FALSE)
write(paste0('Start Information Log File ',
      format(StartTime, "%Y/%d/%m %H:%M:%S")),
      file=infoLog,append = FALSE)
write(paste0('Start Error Log File ',
      format(StartTime, "%Y/%d/%m %H:%M:%S")),
      file=errorLog,append = FALSE)
###########################################
UserName='Practical Data Scientist'
###########################################
write(paste0(UserName,' Load library: ', 'readr'),
      infoLog,append = TRUE)
library(readr) 
write(paste0(UserName,' Load library: ', 'data.table'),
      infoLog,append = TRUE)
library(data.table) 
write(paste0(UserName,' Load library: ', 'tibble'),
      infoLog,append = TRUE)
library(tibble) 
###########################################
FileName=paste0(Base,'/01-Vermeulen/00-RawData/IP_DATA_C_VKHCG.csv')
write(paste0(UserName,' Retrieve data file: ', FileName),
      file=infoLog,append = TRUE)
IP_DATA_C_VKHCG <- read_csv (FileName, 
     col_types = cols(
    `IP Address` = col_character(), 
    `IP Number` = col_double(), 
     w = col_integer(), 
     x = col_integer(), 
     y = col_integer(), 
     z = col_integer()))
###########################################
IP_DATA_C_VKHCG_FIX=set_tidy_names(IP_DATA_C_VKHCG, 
    syntactic = TRUE, quiet = TRUE) 
###########################################
IP_DATA_C_VKHCG_with_ID=rowid_to_column(IP_DATA_C_VKHCG_FIX, var = "RowID")
###########################################
setorderv(IP_DATA_C_VKHCG_with_ID, 'IP.Number', order=-1L, na.last=FALSE)
###########################################
FileNameOut=paste0(FileDir,'/Retrieve_IP_C_VKHCG.csv')
fwrite(IP_DATA_C_VKHCG_with_ID, FileNameOut)
write(paste0(UserName,' Stores Retrieve data file: ', FileNameOut),
      file=infoLog,append = TRUE)
###########################################
StopTime=Sys.time()
###########################################
write(paste0('Stop Debug Log File ',
      format(StopTime, "%Y/%d/%m %H:%M:%S")),
      file=debugLog,append = TRUE)
write(paste0('Stop Information Log File ',
      format(StopTime, "%Y/%d/%m %H:%M:%S")),
      file=infoLog,append = TRUE)
write(paste0('Stop Error Log File ',
      format(StopTime, "%Y/%d/%m %H:%M:%S")),
      file=errorLog,append = TRUE)
###########################################
View(IP_DATA_C_VKHCG_with_ID)
###########################################