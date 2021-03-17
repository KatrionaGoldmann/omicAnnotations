#' genes EMR are interested in
#'
#' @param genes A list of gene names
#' @param types A list of annotation type where each contains a
#' character vector for grep command and general info about the gene. If NULL
#' immune_genes are used
#' @importFrom utils data
#' @export

gene_types <- function(genes, types=NULL){
  
  if(is.null(types)){
    data("immume_genes", package="geneAnnotations")
    types <- immune_genes
  }
  
  df <- data.frame("Gene"=genes, "Type"="", "Function"="", 
                   stringsAsFactors = FALSE)
  for(i in seq_along(types)){
    df$Type[grepl(types[[i]][1], df$Gene)] <- names(types)[i]
    df$Function[grepl(types[[i]][1], df$Gene)] <- types[[i]][2]
  }
  return(df)
}
