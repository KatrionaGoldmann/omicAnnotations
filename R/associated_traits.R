#' What traits are known to be associated with snps (GWAS catalogue)
#'
#' @param snps A list of snp names
#' @param delim The deliminator for returning traits
#' @param verbose Whether to spit out results
#' @references https://www.ebi.ac.uk/gwas/rest/docs/api
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @export

associated_traits <- function(snps,
                              delim="; ",
                              verbose=FALSE){
  
  df <- data.frame("SNPs"=snps, "Associated_traits"="", 
                   stringsAsFactors = FALSE)
  
  lapply(snps, function(g){
    if(verbose) print(g)
    
    call1 = paste0('https://www.ebi.ac.uk/gwas/',
                   'rest/api/singleNucleotidePolymorphisms/',
                   g, '/associations?projection=associationBySnp')
    
    get_assoc <- httr::GET(call1)
    get_assoc_text <- httr::content(get_assoc, "text", encoding = "UTF-8")
    if(get_assoc_text != "" & ! grepl("Internal Server Error", get_assoc_text)){
      get_assoc_json <- jsonlite::fromJSON(get_assoc_text, flatten = FALSE)
      traits <- 
        unique(do.call(rbind, 
                       get_assoc_json$`_embedded`$associations$efoTraits))
      df$"Associated_traits"[df$SNPs == g] <<- 
        paste(traits$trait, collapse=delim)
    } else if(grepl("Internal Server Error", get_prices_text)){
      print("Cannot Reach GWAS catalogue. Please try again later")
    }else{
      if(verbose) print(paste0("Error for", g, 
                               ". No info found - please check snp name."))
    }
  })
  return(df)
}
