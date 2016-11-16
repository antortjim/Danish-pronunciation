library("rvest", quietly = T)
setwd("~/MEGA/Biblioteca/Anki/Antonio/collection.media/")

arguments <- commandArgs(trailingOnly = TRUE)
query <- arguments[1]

ddo.base <- "http://ordnet.dk/ddo/ordbog?query="
ddo.url <- paste(ddo.base, query, sep = "")

ord.entry <- read_html(ddo.url)

audio <- ord.entry %>% 
html_node(".lydskrift .hiddenStructure") %>%
html_nodes(xpath = "./a") %>%   
html_attr("href")


if(length(audio) != 0) {
  message(paste("Found audio file at DDO !", sep = ""))
  filename <- paste(query, "mp3", sep = ".")
  download.file(audio, destfile = filename, quiet = TRUE)
  
} else {
  err.message <- paste("No pronunciation file found for", query, "at DDO", sep = " ")
  stop(err.message)
}
