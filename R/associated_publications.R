#' What publications are available?
#' @param genes A list of gene names
#' @param keywords Words to search with the genes
#' @param split search keywords using AND or OR (default is OR)
#' @param long_format Logical whether to return one row per publication (long) or one per row per gene (wide)
#' @importFrom pbapply pblapply
#' @importFrom easyPubMed get_pubmed_ids fetch_pubmed_data custom_grep
#' @importFrom tidyr separate_rows
#' @export

associated_publications <- function(genes, 
                                    keywords=c("rheumatoid", 
                                               "inflammatory", 
                                               "autoimmune"), 
                                    split="OR", 
                                    long_format=FALSE,
                                    verbose=TRUE){
  
  df <- pblapply(genes, function(g){
    my_query <- paste(g, ' AND (', 
                      paste(keywords, collapse=paste0(" ", split, " ")), ")")
    my_entrez_id <- get_pubmed_ids(my_query)
    hits <- fetch_pubmed_data(my_entrez_id)
    titles <- custom_grep(hits, "ArticleTitle", "char")
    data.frame("Gene"=g, "Publications"=paste(titles, collapse="; "))
  })
  
  do.call(rbind, df)
  
  if(long_format){
    df <- df %>%
      group_by(Gene) %>%
      separate_rows(Publications, sep = "; ")
  }
  
  return(df)
}
