# Main functions

lapply(list("rvest", "httr", "dplyr"), function(x) suppressMessages(library(x, character.only=TRUE)))
library("rvest", quietly = T)
library("httr",  quietly = T)
library("dplyr", quietly = T)

wiktionary.download <- function(query)
{
  # Build url for query
  wiktionary.url <- paste("https://en.wiktionary.org/wiki/", query, "#Danish", sep = "")  
  # Check existence of url
  if(!http_error(wiktionary.url)) {
   # If url exists, read it
   ord.entry <- read_html(wiktionary.url)
     
   # Parse url
   audio <- ord.entry %>% 
   html_node(".mediaContainer source") %>%
   html_attr("src")
   
   # Check if audio file was found
   if(!is.na(audio)) {
     # If audio file is found, download it
     correct <- unlist(strsplit(audio, split = ""))[1] == "h"
     print(correct)
     if(!correct) {
       audio <- paste("https:", audio, sep = "")
     }
     
     message("Found audio file at Wiktionary !")
     filename <- paste(query, "ogg", sep = ".")
     print(audio)
     download.file(audio, destfile = filename, quiet = TRUE)
     invisible(TRUE)
     
   } else {
     # Otherwise (entry exists but without audio file), send error message and exit
     err.message <- paste("No pronunciation file found for", query, "at Wiktionary", sep = " ")
     message(err.message)
     invisible(FALSE)
   }
  }
  else {
    # Return error if url does not exist (entry does not exist)
    err.message <- paste("No entry for", query, "at Wiktionary", sep = " ")
    message(err.message)
    invisible(FALSE)
  }
}

ddo.download <- function(query)
{
 # Build url for query
 ddo.base <- "http://ordnet.dk/ddo/ordbog?query="
 ddo.url <- paste(ddo.base, query, sep = "")
 
 # Read url
 ord.entry <- read_html(ddo.url)
 
 # Parse url
 audio <- ord.entry %>% 
   html_node(".lydskrift .hiddenStructure") %>%
   html_nodes(xpath = "./a") %>%   
   html_attr("href")
 
 # Check if audio file was found
 if(length(audio) != 0) {
   # If audio file is found, download it
   message(paste("Found audio file at DDO !", sep = ""))
   filename <- paste(query, "mp3", sep = ".")
   download.file(audio, destfile = filename, quiet = TRUE)
   invisible(TRUE)
   
 } else {
   # Otherwise, send error message and exit
   err.message <- paste("No pronunciation file found for", query, "at DDO", sep = " ")
   message(err.message)
   invisible(FALSE)
 }
}
