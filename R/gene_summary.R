#' wrapper function to find all info about a list of genes
#'
#' @param genes List of gene names
#' @param verbose Whether to split out the progress
#' @param gene_types Highlight interesting genes?
#' @param gene_summaries Whether to find a summary of the gene info
#' @param associated_diseases Whether to find the associated diseases
#' @param publications Do you want pulication info? (This is time consuming
#' if you have a lot of genes)
#' @param disease_cutoff The DisGeNET Score cutoff
#' @param diseases The MeSH disease classes to use
#' ("C20"=Immune System Diseases)
#' @param publication_keywords Words to search for publications with the genes
#' @param publication_split Whether to use AND or OR when searching the
#' publication keywords (default is OR)
#' @export


gene_summary <- function(genes,
                         verbose=TRUE,
                         gene_types=TRUE,
                         gene_description=TRUE,
                         associated_diseases=TRUE,
                         publications=FALSE,
                         gene_types_list = NULL,
                         disease_cutoff=0,
                         diseases=c("C20", "C05", "C10", "C17"),
                         publication_keywords=c("Rheuamtoid", "Autoimmune"),
                         publication_split="OR"){
  df <- data.frame("Gene"=genes)

  if(gene_types){
    print("Annotating EMR's favourites...")
    df$Type <- gene_types(genes, gene_types_list)$Type
  }

  if(gene_description){
    print("Getting gene summaries...")
    temp <- gene_description(genes)
    df <- cbind(df, temp[match(df$Gene, temp$Gene),
                         c("description", "summary")])
  }

  if(associated_diseases){
    print("Finding associated diseases...")
    temp <- associated_diseases(genes, cutoff=disease_cutoff,
                         disease_classes = diseases, verbose=FALSE)
    df <- cbind(df, temp[match(df$Gene, temp$Gene), 2])
    colnames(df)[ncol(df)] <- "Associated_diseases"
  }

  if(publications){
    print("Getting publications from PubMed...")
    temp <- associated_publications(genes,
                                 keywords = publication_keywords,
                                 split=publication_split)
    df <- cbind(df, temp[match(df$Gene, temp$Gene), 2])
    colnames(df)[ncol(df)] <- "Publications"
  }

  df[is.na(df)] <- ""
  rownames(df) <- df$Gene

  return(df)
}
