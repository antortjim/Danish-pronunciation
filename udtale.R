# Run the functions

# Import the functions
source("download_audio.R")

# Input query danish word from standard input
arguments <- commandArgs(trailingOnly = TRUE)

#print(length(arguments))
# test if there is at least one argument: if not, return an error
if (length(arguments) == 0) {
  stop("At least one argument must be supplied", call. = FALSE)
} else if (length(arguments) == 1) {
  # default output file
  query <- arguments[1]
} else if (length(arguments) == 2) {
  query <- paste(arguments[1:2], collapse = " ")
}


# Read parameters table in input_parameters file
parameters <- read.table(file = "input_parameters", stringsAsFactors = F)

# Set the destination folder to the one specified in the input_parameters file
destination.folder <- filter(parameters, V1 == "destination.folder")[,2]

# Set working directory to destination folder
setwd(destination.folder)

#Builid base.filename
base.filename <- gsub(" ", "_", query)

# Call forvo first. If unsuccesful try ddo. If unsuccesful, try wiktionary
#`%||%` <- function(a, b) if (!is.null(a)) a else b
do.call("ddo.download", list(query, base.filename)) || do.call("forvo.download", list(query, base.filename))
#|| do.call("wiktionary.download", list(query, base.filename)) 

# Output destination file message

# Play the downloaded file
command <- paste("play ", base.filename, ".*", sep = "")
system(command)
