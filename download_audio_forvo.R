library("rvest", quietly = T)
setwd("~/MEGA/Biblioteca/Anki/Antonio/collection.media/")

arguments <- commandArgs(trailingOnly = TRUE)
query <- arguments[1]
query <- "hvad"

forvo.url <- paste("http://forvo.com/word/", query, "/#da", sep = "")

ord.entry <- read_html(forvo.url)

audio <- ord.entry %>% 
html_node(".download") %>%
html_nodes(xpath = "./a") %>%   
html_attr("href")


if(length(audio) != 0) {
  message(paste("Found audio file at ", dict.source, "!", sep = ""))
  filename <- paste(query, "mp3", sep = ".")
  print(url)
  download.file(audio, destfile = filename, quiet = TRUE)
  return(TRUE)
} else {
  err.message <- paste("No pronunciation file found for", query, "at DDO", sep = " ")
  message(err.message)
  return(FALSE)
}

} else {
  web_scraper("Forvo", forvo.url, query, ".download")
}


