#' full gene names
#' @param genes A list of gene names
#' @param name_type What format are the names
#' @importFrom biomaRt getBM useMart
#' @export
full_gene_name <- function(genes, name_type = "hgnc_symbol"){ 
  df <- data.frame("Gene"=genes)
  ensembl <- useMart(biomart="ensembl", dataset="hsapiens_gene_ensembl")
  
  df2 <- getBM(attributes=c("hgnc_symbol", "description"),
               filters = name_type, values=genes, mart=ensembl)
  
  df$Description <- df2$description[match(df$Gene, df2$hgnc_symbol)]
}


#' Rentrez gene descriptions
#' @param genes A list of gene names
#' @param retmax The number of NCBI hits to try. If you are struggling to find
#' info try increasing this, although it will become slower (default=50). 
#' @importFrom pbapply pblapply
#' @importFrom rentrez entrez_search extract_from_esummary entrez_summary
#' @export
gene_description <- function(genes, retmax=50){
  all.df <- pblapply(genes, function(g) {
    r_search <- entrez_search(db="gene", term=g, retmax=retmax)
    if(length(r_search$ids) > 0){
      info <- entrez_summary(db="gene", id=r_search$ids, version="2.0")
      df <- data.frame(
        "Gene"=g, 
        "name"=extract_from_esummary(info, "name"),
        "description"=extract_from_esummary(info, "description"), 
        "summary"=extract_from_esummary(info, "summary"),
        "aliases"=extract_from_esummary(info, "otheraliases"),
        "id"=extract_from_esummary(info, "uid"),
        stringsAsFactors = FALSE)
      rownames(df) <- df$Gene
      
      df <- df[df$name == g, ]
      if(nrow(df) > 0){
        df <- t(data.frame(apply(df, 2, function(x){
          x <- x[x != ""]
          paste(unique(x), collapse="; ")
        })))
        colnames(df) <- c("Gene", "name",  "description", 
                          "summary", "alias", "id")
      }
    } else{
      df <- data.frame("Gene"=g, "name"=g, "description"="", "summary"="", 
                       "alias"="", "id"="")
    }
    df[is.na(df)] <- ""
    return(df)
  })
  final.df <- do.call(rbind, all.df)
  return(final.df)
}
