#' The known eQTL for snps or genes (eQTL catalogue)
#'
#' @param snps A list of snp names
#' @param genes A list of gene names (ensembl IDs)
#' @param p_cutoff The pvalue cutoff for returning associations
#' @param verbose Whether to spit out results
#' @param ncores The number of cores to use
#' @references https://www.ebi.ac.uk/eqtl/api-docs/
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom pbmcapply pbmclapply
#' @export

associated_eqtl <- function(snps=c(),
                            genes=c(),
                            p_cutoff = 1,
                            verbose=FALSE, 
                            ncores=2){
  
  print("Looking at SNPs")
  snp_df <- invisible(pbmclapply(snps, function(rssnp){
    
    call1 <- paste0("https://www.ebi.ac.uk/eqtl/api/associations/", rssnp)
    
    get_assoc <- httr::GET(call1)
    get_assoc_text <- httr::content(get_assoc, "text", encoding = "UTF-8")
    if(get_assoc_text != "" & ! grepl("Internal Server Error", get_assoc_text)){
      get_assoc_json <- jsonlite::fromJSON(get_assoc_text, flatten = FALSE)
      traits <- unique(do.call(rbind, get_assoc_json$`_embedded`$associations))
      return( data.frame(traits))
    } else {return(NULL)}
  }, mc.cores=ncores))
  snp_df <- do.call(rbind, snp_df)
  
  print("Looking at Genes")
  gene_df <- invisible(pbmclapply(genes, function(g){
    
    call1 <- paste0("https://www.ebi.ac.uk/eqtl/api/genes/", g, "/associations")
    
    get_assoc <- httr::GET(call1)
    get_assoc_text <- httr::content(get_assoc, "text", encoding = "UTF-8")
    if(get_assoc_text != "" & ! grepl("Internal Server Error", get_assoc_text)){
      get_assoc_json <- jsonlite::fromJSON(get_assoc_text, flatten = FALSE)
      traits <- unique(do.call(rbind, get_assoc_json$`_embedded`$associations))
      # df <<- rbind(df, )
      return(data.frame(traits))
    } else{ return(NULL)}
  }, mc.cores=ncores))
  gene_df <- do.call(rbind, gene_df)
  
  df <- rbind(snp_df, gene_df)
  
  numeric_cols <- suppressWarnings(unlist(sapply(df, function(x) {
    ! all(is.na(as.numeric(as.character(x))))
  } )))
  
  df[, numeric_cols] <- suppressWarnings(
    sapply( df[, numeric_cols], function(x)  {
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

