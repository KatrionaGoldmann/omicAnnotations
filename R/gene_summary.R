#' wrapper function to find all info about a list of genes
#'
#' @param genes List of gene names
#' @param verbose Whether to split out the progress
#' @param get_gene_types Highlight interesting genes?
#' @param get_gene_description Whether to find a summary of the gene info
#' @param get_associated_diseases Whether to find the associated diseases
#' @param get_publications Do you want publication info? (This is time consuming
#' if you have a lot of genes)
#' @param gene_types_df A data frame of annotation types with columns for: the 
#' annotation name, the contains a
#' character vector for grep command and general info about the gene. If NULL
#' system.file("extdata","immune_genes.txt", package = "omicAnnotations")
#' @param ncbi_retmax The number of NCBI hits to try. If you are struggling to 
#' find info try increasing this, although it will become slower (default=50). 
#' @param disease_cutoff The DisGeNET Score cutoff
#' @param disease_source The source of the GDA (see 
#' https://www.disgenet.org/dbinfo)
#' @param disease_api_token The authentication token by DisGenNet (Sign up here: 
#' https://www.disgenet.org/signup/). Then run get_api_key(email, password). 
#' @param diseases The MeSH disease classes to use
#' ("C20"=Immune System Diseases)
#' @param publication_keywords Words to search for publications with the genes
#' @param publication_split Whether to use AND or OR when searching the
#' publication keywords (default is OR)
#' @export


gene_summary <- function(genes,
                         verbose=TRUE,
                         get_gene_types=TRUE,
                         get_gene_description=TRUE,
                         get_associated_diseases=TRUE,
                         get_publications=FALSE,
                         gene_types_df = NULL,
                         ncbi_retmax=50,
                         disease_cutoff=0,
                         disease_source = "curated",
                         disease_api_token=NULL,
                         diseases=c("C20", "C05", "C10", "C17"),
                         publication_keywords=c("Rheumatoid", "Autoimmune"),
                         publication_split="OR"){
  df <- data.frame("Gene"=genes)
  
  if(get_gene_types){
    print("Annotating from self-curated data...")
    temp <- gene_types(genes, gene_types_df)
    df$Type <- temp$Type
    df$Curated_description <- temp$Description
  }
  
  if(get_gene_description){
    print("Getting gene summaries...")
    temp <- data.frame(gene_description(genes))
    df <- cbind(df, temp[match(df$Gene, temp[, "Gene"]),
                         c("description", "summary")])
  }
  
  if(get_associated_diseases){
    if(is.null(disease_api_token)){
      stop(
        paste("disease_api_token not given, cannot look for associated", 
              "diseases. To include you must have an api token from", 
              "disGenNet. Sign up here: https://www.disgenet.org/signup/.", 
              "Then run get_api_key(email, password)"))
    } else{
      print("Finding associated diseases...")
      temp <- associated_diseases(genes, cutoff=disease_cutoff,
                                  disease_classes = diseases, 
                                  api_token = disease_api_token,
                                  source = disease_source,
                                  verbose=FALSE)
      df <- cbind(df, temp[match(df$Gene, temp$Gene), 2])
      colnames(df)[ncol(df)] <- "Associated_diseases"
    }
  }
  
  if(get_publications){
    print("Getting publications from PubMed...")
    temp <- associated_publications(genes,
                                    keywords = publication_keywords,
                                    split=publication_split)
    df <- cbind(df, temp[match(df$Gene, temp$Gene), 2])
    colnames(df)[ncol(df)] <- "Publications"
  }
  
  df[is.na(df)] <- ""
  
  return(df)
}
