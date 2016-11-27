library("rvest", quietly = T)
setwd("~/MEGA/Biblioteca/Anki/Antonio/collection.media/")

arguments <- commandArgs(trailingOnly = TRUE)
query <- arguments[1]

wiktionary.url <- paste("https://en.wiktionary.org/wiki/", query, "#Danish", sep = "")  
ord.entry <- read_html(wiktionary.url)
  
audio <- ord.entry %>% 
html_node(".mediaContainer source") %>%
html_attr("src")


if(!is.na(audio)) {
  correct <- unlist(strsplit(audio, split = ""))[1] == "h"
  print(correct)
  if(!correct)
  {
    audio <- paste("https:", audio, sep = "")
  }
  message("Found audio file at Wiktionary !")
  filename <- paste(query, "ogg", sep = ".")
  print(audio)
  download.file(audio, destfile = filename, quiet = TRUE)
  
} else {
  err.message <- paste("No pronunciation file found for", query, "at Wiktionary", sep = " ")
  stop(err.message)
}
