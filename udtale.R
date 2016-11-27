# Run the functions

# Import the functions
source("download_audio.R")

# Input query danish word from standard input
query <- commandArgs(trailingOnly = TRUE)[1]

# Read parameters table in input_parameters file
parameters <- read.table(file = "input_parameters", stringsAsFactors = F)

# Set the destination folder to the one specified in the input_parameters file
destination.folder <- filter(parameters, V1 == "destination.folder")[,2]

# Set working directory to destination folder
setwd(destination.folder)

# Call ddo first. If unsuccesful, try wiktionary
do.call("ddo.download", list(query)) || do.call("wiktionary.download", list(query)) 
