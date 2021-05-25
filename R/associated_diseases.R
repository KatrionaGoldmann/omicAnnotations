#' What diseases are known to be associated with genes
#'
#' @param genes A list of gene names
#' @param cutoff The DisGeNET Score cutoff
#' @param disease_classes The MeSH disease classes to use
#' ("C20"=Immune System Diseases)
#' @param source The source of the GDA (see https://www.disgenet.org/dbinfo)
#' @param delim The deliminator for returning traits
#' @param api_token The authentication token by DisGenNet (Sign up here: 
#' https://www.disgenet.org/signup/). Then run get_api_key(email, password). 
#' @param verbose Whether to spit out results
#' @references https://www.disgenet.org/api/#/GDA/gdaByGene
#' @importFrom httr GET content add_headers
#' @importFrom jsonlite fromJSON
#' @export

associated_diseases <- function(genes,
                                api_token,
                                cutoff=0,
                                disease_classes=c("C20", "C05", "C10", "C17"),
                                source = "CURATED",
                                delim="; ", 
                                verbose=TRUE){
  
  if(is.null(api_token) | is.na(api_token)){
    stop(paste("You must have an api token from disGenNet.",
               "\n Sign up here: https://www.disgenet.org/signup/. ", 
               "Then run get_api_key(email, password)"))
  }
  
  df <- data.frame("Gene"=genes, "Associated_diseases"="", 
                   stringsAsFactors = FALSE)
  
  lapply(genes, function(g){
    if(verbose) print(g)
    
    cutoff_query <- paste0("?min_score=", cutoff)
    if(!is.null(disease_classes)) {
      disease_query <- paste0(paste0("&disease_class=", disease_classes),
                              collapse="")
    } else {disease_query<-""}
    
    source <- toupper(source)
    if(source != "ALL"){
      source_query <- paste0(paste0("&source=", source),
                             collapse="")
    } else{source_query <- ""}
    
    call <- paste0('https://www.disgenet.org/api/gda/gene/', g, 
                   cutoff_query, source_query,  disease_query)
    
    get_diseases <- GET(call, 
                        add_headers(accept= "*/*", 
                                    Authorization= paste("Bearer", api_token)))
    get_diseases_text <- httr::content(get_diseases, "text", encoding = "UTF-8")
    if(get_diseases_text != ""){
      get_diseases_json <- fromJSON(get_diseases_text, flatten = FALSE)
      diseases <- unique(get_diseases_json$disease_name)
    } else{diseases<-""}
    df$"Associated_diseases"[df$Gene == g] <<- paste(diseases, collapse=delim)
  })
  
  colnames(df)[2] <- paste0("Diseases_minscore_", cutoff, "_class_",
                            paste(disease_classes, collapse="_"))
  return(df)
}


#' Retrieves the DisGeNET API key for a user
#'
#' Given the email and password, retrieves the users API Key
#' @param email the email of the user
#' @param password the password of the user to connect to DisGeNET
#' @return A string
#' @importFrom httr GET content add_headers POST http_status
#' @importFrom jsonlite fromJSON
#' @examples
#' # Not a real account so will return an error
#' get_api_key(email="user@gmail.com", password="myspwd")
#' @export
get_api_key <- function(email, password) {
  r  <- httr::POST(url = "https://www.disgenet.org/api/auth/", 
                   httr::add_headers(.headers=c(`accept` =  '*/*' )),
                   body = list(`email` = email, `password` = password))
  
  if (r$status_code == 200) {
    api_key <- fromJSON(httr::content( r, as = "text", encoding = "UTF-8"), 
      flatten = FALSE)$token
  }else{
    print(httr::http_status(r))
    print(httr::content(r, "text"))
    api_key <-  NULL
  }
  return(api_key)
}
