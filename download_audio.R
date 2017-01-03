# Main functions

lapply(list("rvest", "httr", "dplyr", "stringr", "xml2"), function(x) suppressMessages(library(x, character.only=TRUE)))

not.found <- "No entry/audio found at "
found <- "Success at "

wiktionary.download <- function(query, base.filename)
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
   
   
   # Check if Danish audio file was found
   if(!is.na(audio)) {
     lang <- tolower(str_match(pattern= ".*\\/(\\w{2})-\\w*.ogg", audio)[,2])
     if(lang != "da")
     {
       err.message <- paste("Audio file found for", query, "at Wiktionary but in language", lang, sep = " ")
       message(err.message)
       invisible(FALSE)
     } else {
     # If audio file is found, refine the url and download it
     # The url refinement adds https: in case it does not have it (requiered for downlad.file later)
     correct <- unlist(strsplit(audio, split = ""))[1] == "h"
     #print(correct)
     if(!correct) {
       audio <- paste("https:", audio, sep = "")
     }

     message(found, "Wiktionary !")
     filename <- paste(base.filename, "ogg", sep = ".")
     
     #print(audio)
     download.file(audio, destfile = filename, quiet = TRUE)
     invisible(TRUE)
     
     
   }} else  {
       # Otherwise (entry exists but without Danish audio file), send error message and exit
       err.message <- paste(not.found, "Wiktionary", sep = " ")
       message(err.message)
       invisible(FALSE)
  }} else  {
      # Return error if url does not exist (entry does not exist)
      err.message <- paste(not.found, "Wiktionary", sep = " ")
      message(err.message)
      invisible(FALSE)
   }
}

ddo.download <- function(query, base.filename)
{
 message("Searching Den Danske Ordbog")
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
   message(paste(found, "DDO !", sep = ""))
   filename <- paste(base.filename, "mp3", sep = ".")
   download.file(audio, destfile = filename, quiet = TRUE)
   message("Saving to file ", base.filename, ".mp3", sep = "")
   invisible(TRUE)
   
 } else {
   # Otherwise, send error message and exit
   err.message <- paste(not.found, "DDO", sep = " ")
   message(err.message)
   invisible(FALSE)
 }
}



fileName <- 'forvo_key'
forvo.key <- readChar(fileName, file.info(fileName)$size) 
forvo.key <- substr(forvo.key, 1, nchar(forvo.key) - 1)

forvo.download <- function(query, base.filename) {
  message("Searching Forvo")
  # Build url for query using FORVO api
  forvo.url <- paste("https://apifree.forvo.com/key", forvo.key, "format/xml/action/word-pronunciations/word",
                     query, "language/da", sep = "/")

  print(forvo.url)
  
  # Read url
  ord.entry <- read_xml(forvo.url)
  
  if(!length(ord.entry %>% xml_children) == 0)
  {
    # Parse url. By default choose first option
    audio.url <- ((ord.entry %>% xml_children)[1] %>% xml_contents)[12] %>% xml_text
    audio.file <- paste(base.filename, "ogg", sep = ".")
    # Download
    download.file(url = audio.url, destfile = audio.file, quiet = TRUE)
    # Return exit status
    message(found, "Forvo")
    message("Saving to file ", base.filename, ".ogg", sep = "")
    
    invisible(TRUE)
  } else {
    # Not found in forvo
    message(not.found, "Forvo!")
    invisible(FALSE)
  }
}
