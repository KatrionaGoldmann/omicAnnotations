#' What snps are known to be associated with gene (GWAS catalogue)
#'
#' @param genes A list of gene names (symbol or ensembl)
#' @param delim The deliminator for returning traits
#' @param verbose Whether to spit out results
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @export

associated_snps <- function(genes=c(),
                            delim="; ",
                            verbose=FALSE){
  
  df <- data.frame("Genes"=genes, "Associated_snps"="", 
                   "Traits_associated_to_snps"="", 
                   stringsAsFactors = FALSE)
  
  
  lapply(snps, function(g){
    if(verbose) print(g)
    
    call1 <- paste0('https://www.ebi.ac.uk/gwas/rest/api/', 
                    'singleNucleotidePolymorphisms/search/findByGene?',
                    g)
    
    get_assoc <- httr::GET(call1)
    get_assoc_text <- httr::content(get_assoc, "text", encoding = "UTF-8")
    if(get_assoc_text != "" & ! grepl("Internal Server Error", get_assoc_text)){
      get_assoc_json <- jsonlite::fromJSON(get_assoc_text, flatten = FALSE)
      snps <- get_assoc_json$`_embedded`$singleNucleotidePolymorphisms$rsId
      df$Associated_snps[df$Genes == g] <<- paste0(snps, collapse = "; ")
      snps <- unlist(strsplit(snps, split=" x "))
      temp <- associated_traits(snps)
      df$Traits_associated_to_snps[df$Genes == g] <<- 
        paste0(unique(unlist(strsplit(temp$Associated_traits, split="; "))), 
               collapse=delim)
      
    } else if(grepl("Internal Server Error", get_prices_text)){
      print("Cannot Reach GWAS catalogue. Please try again later")
    }else{
      if(verbose) print(paste0("Error for", g, 
                               ". No info found - please check snp name."))
    }
  })
  return(df)
}
