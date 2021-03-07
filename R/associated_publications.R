#' What publications are available?
#' @param genes A list of gene names
#' @param keywords Words to search with the genes
#' @param split search keywords using AND or OR (default is OR)
#' @importFrom pbapply pblapply
#' @importFrom easyPubMed get_pubmed_ids fetch_pubmed_data custom_grep
associated_publications <- function(genes, 
                                 keywords=c("rheumatoid", 
                                            "inflammatory", 
                                            "autoimmune"), 
                                 split="OR", 
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
}