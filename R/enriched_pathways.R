#' returns pathways from enrichR
#' @param genes List of gene names
#' @param drop_terms terms in databases not to search. If NULL only keep_terms
#' used
#' @param keep_terms terms in databases to search. If NULL only all except
#' drop_terms used
#' @param dbs database of enrichR pathways. If NULL all are selected minus
#' those removed by drop_terms. See listEnrichrDbs().
#' @param cutoff pvalue cutoff
#' @param min_N minimum number of genes to consider
#' @param remove_old Whether to remove legacy libraries ()
#' @param libraries Which type of libraries to check for enrichment. Options
#' include c('Transcription', 'Pathways', 'Ontologies', 'Diseases_Drugs',
#' 'Cell_Types', 'Misc'))
#' @param plot_cap Maximum number of terms to plot
#' @param plot_pcutoff Pvalue cutoff for plotting
#' @param plot_colour Parameter for the colour scaling
#' @param plot_x Parameter to plot on the x-axis
#' @param plot_vline Position for vertical line
#' @param check_for_updates Whether to check for updates in the enrichR database
#' @importFrom enrichR enrichr
#' @importFrom ggplot2 ggplot geom_bar coord_flip theme_minimal labs
#' scale_fill_continuous guide_colorbar geom_hline aes_string
#' @importFrom stats ave
#' @importFrom utils read.table
#' @export

enriched_pathways <- function(genes,
                              drop_terms=c("User", "Enrichr"),
                              keep_terms=c(),
                              dbs=NULL,
                              cutoff=0.05,
                              min_N=2,
                              remove_old = TRUE,
                              libraries = c('Transcription', 'Pathways'),
                              plot_cap=20,
                              plot_pcutoff=0.01,
                              plot_colour = "Combined.Score",
                              plot_x="P.value",
                              plot_vline=NA,
                              check_for_updates=TRUE){

  require(enrichR)
  
  if(any(! libraries %in% c('Transcription', 'Pathways', 'Ontologies',
                            'Diseases_Drugs', 'Cell_Types', 'Misc'))){
    stop(paste("libraries must be in c('Transcription', 'Pathways',",
               "'Ontologies', 'Diseases_Drugs', 'Cell_Types', 'Misc')"))
  }

  if(check_for_updates) enrichr_update_check()

  if(is.null(dbs)) {
    file_name <- system.file("extdata","enrichr_libraries.csv",
                             package = "omicAnnotations")
    print(paste("Using", file_name, "databases"))
    enrichr_library <- read.table(file_name, sep=",",
                                  header=TRUE, stringsAsFactors = FALSE)
    
    dbs <- enrichr_library
    pathways <- apply(data.frame(dbs[, libraries], stringsAsFactors = FALSE), 1,
                      function(r) any(r=="x"))
    dbs <- dbs[pathways, ]
  }
  if(remove_old){
    dbs <- dbs[dbs$Legacy != "x", ]
  }
  if(length(drop_terms) > 0) {
    dbs <- dbs[! grepl(paste0(drop_terms, collapse="|"), dbs$libraryName,
                       ignore.case = TRUE), ]
  }
  if(length(keep_terms) > 0) {
    dbs <- dbs[grepl(paste0(keep_terms, collapse="|"), dbs$libraryName,
                     ignore.case = TRUE), ]
  }

  enriched <- enrichr(genes, dbs$libraryName)

  if(length(enriched) == 0) stop("no libraries")
  temp <- do.call(rbind, enriched)
  temp$Library <- gsub("\\..*", "", rownames(temp))
  if(length(drop_terms) > 0) {
    temp <- temp[! grepl(paste0(drop_terms, collapse="|"), temp$Term,
                         ignore.case = TRUE), ]
  }
  if(length(keep_terms) > 0) {
    temp <- temp[! grepl(paste0(keep_terms, collapse="|"), temp$Term,
                         ignore.case = TRUE), ]
  }

  temp <- temp[, c('Term', 'Library',  'Overlap', 'P.value', 'Adjusted.P.value',
                  'Old.P.value', 'Old.Adjusted.P.value', 'Odds.Ratio',
                  'Combined.Score', 'Genes')]

  temp$N <- as.numeric(gsub("/.*", "", temp$Overlap))
  temp <- temp[temp$N >= min_N, ]
  temp <- temp[temp$P.value <= cutoff, ]

  temp <- temp[order(temp$P.value), ]

  if(nrow(temp)<=1) stop("Need more than one pathway")
  plot_df <- temp[temp$P.value < plot_pcutoff, ]
  plot_df[, plot_x] <- as.numeric(as.character(plot_df[, plot_x]))
  plot_df <- plot_df[order(plot_df[, plot_x]), ]
  plot_df <- plot_df[1:(min(nrow(plot_df), plot_cap, na.rm=TRUE)), ]
  plot_df$count <- ave(as.character(plot_df$Term), plot_df$Term,
                       FUN = seq_along)

  plot_df$Term[plot_df$count != 1] <- paste0(plot_df$Term,
                                             " (", plot_df$count,
                                             ")")[plot_df$count != 1]
  plot_df$Term <- factor(plot_df$Term, levels=rev(unique(plot_df$Term)))
  plot_df$x <- plot_df[, plot_x]
  plot_df$col <- plot_df[, plot_colour]

  if(grepl("P.value", plot_x)) {
    plot_df$x <- -log10(plot_df$x)
    plot_x <- paste0("-log(", plot_x, ")")
  }

  plot <- ggplot(plot_df, aes_string(x="Term", y="x", fill="col")) +
    geom_bar(stat="identity") +
    coord_flip() +
    theme_minimal() +
    labs(x="", y=plot_x, fill=plot_colour) +
    scale_fill_continuous(low="red", high="midnightblue",
                          guide=guide_colorbar(reverse=grepl("P.value",
                                                             plot_colour)))

  if(! is.na(plot_vline)) {
    plot <- plot + geom_hline(yintercept = plot_vline,
                              colour="grey60", linetype="dashed")
  }

  temp_genes <- sort(table(unlist(strsplit(temp$Genes,  ";"))), decreasing=TRUE)


  return(list(enrichment=temp, enrichment_genes_table=temp_genes, plot=plot))
}

#' @importFrom enrichR listEnrichrDbs
#' @export
enrichr_update_check <- function(){
  file_name <- system.file("extdata","enrichr_libraries.csv",
                           package = "omicAnnotations")
  enrichr_library <- read.table(file_name, sep=",",
                                header=TRUE, stringsAsFactors = FALSE)


  enrichrdbs <-  listEnrichrDbs()

  enrichr_update <- enrichrdbs$libraryName[! enrichrdbs$libraryName %in%
                                             enrichr_library$libraryName]

  if(length(enrichr_update) > 0){
    warning(paste("enrichr library csv needs to be updated. Missing:",
                  paste(enrichr_update, collapse=", ")))
  }
  remove(enrichr_update, enrichrdbs)
}
