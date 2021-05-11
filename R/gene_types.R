#' genes EMR are interested in
#'
#' @param genes A list of gene names
#' @param types A data frame of annotation types with columns for: the a
#' nnotation name, the contains a
#' character vector for grep command and general info about the gene. If NULL
#' immune_genes are used
#' @importFrom utils data
#' @export

gene_types <- function(genes, types=NULL){
  
  if(is.null(types)){
    file_name <- system.file("extdata","immune_genes.txt",
                             package="omicAnnotations")
    types <- read.table(file_name, header=T)
  }
  
  df <- data.frame("Gene"=genes, "Type"="", "Description"="", 
                   stringsAsFactors = FALSE)
  
  invisible(apply(types[, c("name", "grep_term", "description")], 1, 
                  function(x) {
                    df$Type[grepl(x[2], df$Gene)] <<- x[1]
                    df$Description[grepl(x[2], df$Gene)] <<- x[3]
                  }))

  return(df)
}
