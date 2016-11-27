# Run the functions

## Imports the functions
source("download_audio.R")

# CUSTOMIZE TO FIT YOUR NEEDS
# setwd("/route/to/destionation/folder")
setwd("~/MEGA/Biblioteca/Anki/Antonio/collection.media/")

# Read query danish word
arguments <- commandArgs(trailingOnly = TRUE)
query <- arguments[1]

# Call ddo first. If unsuccesful, try wiktionary
do.call("ddo.download", list("første")) || do.call("wiktionary.download", list("første")) 


