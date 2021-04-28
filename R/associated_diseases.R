#' What diseases are known to be associated with genes
#'
#' @param genes A list of gene names
#' @param cutoff The DisGeNET Score cutoff
#' @param disease_classes The MeSH disease classes to use
#' ("C20"=Immune System Diseases)
#' @param delim The deliminator for returning traits
#' @param verbose Whether to spit out results
#' @references https://www.disgenet.org/api/#/GDA/gdaByGene
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @export

associated_diseases <- function(genes,
                                cutoff=0,
                                disease_classes=c("C20", "C05", "C10", "C17"),
                                delim="; ",
                                verbose=TRUE){
  
  df <- data.frame("Gene"=genes, "Associated_diseases"="", 
                   stringsAsFactors = FALSE)
  
  lapply(genes, function(g){
    if(verbose) print(g)
    cutoff_query <- paste0("?min_score=", cutoff)
    if(!is.null(disease_classes)) {
      disease_query <- paste0(paste0("&disease_class=", disease_classes),
                              collapse="")
    } else {disease_query<-""}
    
    call <- paste0('https://www.disgenet.org/api/gda/gene/', g,
                   cutoff_query, disease_query)
    
    get_diseases <- GET(call)
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
