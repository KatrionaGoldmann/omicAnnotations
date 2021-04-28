#' The known eQTL for snps or genes (eQTL catalogue)
#'
#' @param snps A list of snp names
#' @param genes A list of gene names (ensembl IDs)
#' @param p_cutoff The pvalue cutoff for returning associations
#' @param verbose Whether to spit out results
#' @references https://www.ebi.ac.uk/eqtl/api-docs/
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @export

associated_eqtl <- function(snps=c(),
                            genes=c(),
                            p_cutoff = 1e-5,
                            verbose=FALSE){
  
  df <- data.frame()
  
  invisible(lapply(snps, function(rssnp){
    
    call1 = paste0("https://www.ebi.ac.uk/eqtl/api/associations/", rssnp)
    
    get_assoc <- httr::GET(call1)
    get_assoc_text <- httr::content(get_assoc, "text", encoding = "UTF-8")
    if(get_assoc_text != "" & ! grepl("Internal Server Error", get_assoc_text)){
      get_assoc_json <- jsonlite::fromJSON(get_assoc_text, flatten = FALSE)
      traits <- unique(do.call(rbind, get_assoc_json$`_embedded`$associations))
      df <<- rbind(df, data.frame(traits))
    }   
  }))
  
  invisible(lapply(genes, function(g){
    
    call1 = paste0("https://www.ebi.ac.uk/eqtl/api/genes/", g, "/associations")
    
    get_assoc <- httr::GET(call1)
    get_assoc_text <- httr::content(get_assoc, "text", encoding = "UTF-8")
    if(get_assoc_text != "" & ! grepl("Internal Server Error", get_assoc_text)){
      get_assoc_json <- jsonlite::fromJSON(get_assoc_text, flatten = FALSE)
      traits <- unique(do.call(rbind, get_assoc_json$`_embedded`$associations))
      df <<- rbind(df, data.frame(traits))
    }   
  }))
  
  numeric_cols <- suppressWarnings(unlist(sapply(df, function(x) {
    ! all(is.na(as.numeric(as.character(x))))
  } )))
  
  df[, numeric_cols] <- suppressWarnings(sapply( df[, numeric_cols], function(x)  {
    as.numeric(as.character(x))
  }))
  
  df <- df[df[, "pvalue"] <= p_cutoff, ]
  df <- df[order(df[, "pvalue"]), 
           c('rsid', 'chromosome', 'molecular_trait_id', 'gene_id', 'tissue', 
             'qtl_group', 'pvalue', 'neg_log10_pvalue', 'se', 'beta', 
             'median_tpm', 'study_id',  'type', 'alt', 'position', 'ac', 'maf', 
             'variant', 'ref', 'r2', 'an')]
  
  return(df)
}
