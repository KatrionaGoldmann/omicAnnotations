#' Multi-tissue eqtl 
#'
#' @param genes A list of gene names in format genecode IDs
#' @param snps SNPs. In format chr11_66561248_T_C
#' @param gene_snp_pairs A data frame of gene-snp pairs with genes in the first
#' column and snps in the second
#' @param p_only Whether to keep only the p-value statistics
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @export
gtex_eqtl <- function(genes=c("CYP26B1"),
                      snps=c("chr2_72209800_G_A"),
                      gene_snp_pairs=c(),
                      p_only=TRUE, 
                      gencodeIDs=FALSE){
  
  if(length(gene_snp_pairs) == 0){
    df <- expand.grid(genes, snps)
  } else{
    df <- gene_snp_pairs
  }
  colnames(df) <- c("Gene", "SNP")
  df$gene_name <- df$Gene
  df$Gene <- as.character(df$Gene)
  df$SNP <- as.character(df$SNP)
  
  if(! gencodeIDs){
    # First get the versioned genecodes
    for(i in unique(df$Gene)){
      gene_call <- 
        paste0("https://gtexportal.org/rest/v1/reference/gene?geneId=", i, 
               "&gencodeVersion=v26&genomeBuild=GRCh38%2Fhg38&pageSize=250",
               "&format=json")
      
      get_gene <- GET(gene_call)
      get_gene_text <- httr::content(get_gene, "text", encoding = "UTF-8")
      if(get_gene_text != ""){
        gencode <- fromJSON(get_gene_text, flatten = FALSE)$gene$gencodeId
        if(! is.null(gencode)) df$Gene[df$Gene == i] <- gencode
      }
      
    }
  }
  
  
  out_df <- data.frame()
  for(i in 1:nrow(df)){
    call <- 
      paste0("https://gtexportal.org/rest/v1/association/metasoft?variantId=",
             df$SNP[i], "_b38&gencodeId=", df$Gene[i], "&datasetId=gtex_v8")
    get_eqtl <- GET(call)
    get_eqtl_text <- httr::content(get_eqtl, "text", encoding = "UTF-8")
    if(get_eqtl_text != ""){
      gtex_list <- fromJSON(get_eqtl_text, flatten = FALSE)
      gtex_df <- gtex_list$metasoft
      if(length(gtex_df) > 0){
        gtex_df <- do.call(data.frame, gtex_df)
        gtex_df <- gtex_df[, c("datasetId", "gencodeId", "variantId", "metaP", 
                              colnames(gtex_df)[! colnames(gtex_df) %in% 
                                                  c("datasetId", "gencodeId", 
                                                    "metaP" , "variantId")])]
      } else{
        gtex_df <- t(data.frame(c("gtex_v8", as.character(df$Gene[i]), 
                                 as.character(df$SNP[i]), NA, rep(NA, 49*4)), 
                               stringsAsFactors = FALSE))
        
        colnames(gtex_df) <- 
          c('datasetId', 'gencodeId',  'variantId', 'metaP',
            paste0(rep(c('Adipose_Subcutaneous', 'Adipose_Visceral_Omentum', 
                         'Adrenal_Gland', 'Artery_Aorta', 'Artery_Coronary', 
                         'Artery_Tibial', 'Brain_Amygdala', 
                         'Brain_Anterior_cingulate_cortex_BA24', 
                         'Brain_Caudate_basal_ganglia', 
                         'Brain_Cerebellar_Hemisphere', 
                         'Brain_Cerebellum', 'Brain_Cortex', 
                         'Brain_Frontal_Cortex_BA9', 
                         'Brain_Hippocampus', 'Brain_Hypothalamus', 
                         'Brain_Nucleus_accumbens_basal_ganglia', 
                         'Brain_Putamen_basal_ganglia', 
                         'Brain_Spinal_cord_cervical_c-1', 
                         'Brain_Substantia_nigra', 
                         'Breast_Mammary_Tissue', 'Cells_Cultured_fibroblasts', 
                         'Cells_EBV-transformed_lymphocytes', 'Colon_Sigmoid', 
                         'Colon_Transverse', 
                         'Esophagus_Gastroesophageal_Junction', 
                         'Esophagus_Mucosa', 'Esophagus_Muscularis', 
                         'Heart_Atrial_Appendage', 
                         'Heart_Left_Ventricle', 'Kidney_Cortex', 'Liver', 
                         'Lung', 
                         'Minor_Salivary_Gland', 'Muscle_Skeletal', 
                         'Nerve_Tibial', 
                         'Ovary', 'Pancreas', 'Pituitary', 'Prostate', 
                         'Skin_Not_Sun_Exposed_Suprapubic', 
                         'Skin_Sun_Exposed_Lower_leg', 
                         'Small_Intestine_Terminal_Ileum', 'Spleen', 'Stomach', 
                         'Testis', 
                         'Thyroid', 'Uterus', 'Vagina', 'Whole_Blood'), each=4),
                   rep(c(".mValue", ".nes", ".pValue", ".se"), 49)))
      }
      out_df <- rbind(out_df, gtex_df)
    } 
  }
  if(p_only) out_df <- out_df[, grepl('Id|metaP|pValue', colnames(out_df))]
  out_df$Gene <- df$gene_name[match(out_df$gencodeId, df$Gene)]
  out_df <- out_df[, c(ncol(out_df), c(1:(ncol(out_df)-1)))]
  
  return(out_df)
}


#' gtex eqtl heatmap
#'
#' @param df A list of gene names in format genecode IDs
#' @param colour_low Colour for most significant 
#' @param colour_high Colour for least significant 
#' @param grid_colour Colour for heatmap grid
#' @param ... 
#' @importFrom circlize colorRamp2
#' @importFrom ComplexHeatmap Heatmap
#' @importFrom grid gpar
#' @export

gtex_heatmap <- function(df, 
                         colour_low = "white",
                         colour_high = "blue", 
                         grid_colour=NULL, 
                         p_cutoff=0.05,
                         ...){
  rownames(df) <- paste0(df$Gene, "\n", df$variantId)
  temp <- df[, grepl("pValue", colnames(df)), drop=FALSE]
  temp <- -log10(temp)
  
  colnames(temp) <- gsub("\\.pValue", "", colnames(temp))
  m <- max(temp, na.rm=TRUE)
  temp[is.na(temp)] <- m + 1e-50
  
  col_fun <- colorRamp2(c(0, -log10(0.05), -log10(0.05), m), 
                       c( "grey60", colour_low, colour_low, colour_high))
  
  Heatmap(t(temp),  name="-log10(p-value)",  col = col_fun, ..., 
          rect_gp = gpar(col = grid_colour, lwd = 2))
  
}
