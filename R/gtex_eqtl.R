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


gtex_eqtl <- function(genes=c("ENSG00000248746.5"),
                      snps=c("chr11_66561248_T_C"),
                      gene_snp_pairs=c(),
                      p_only=TRUE){
  
  if(length(gene_snp_pairs) == 0){
    df <- expand.grid(genes, snps)
  } else{
    df <- gene_snp_pairs
  }
  colnames(df) <- c("Gene", "SNP")
  
  
  out_df = data.frame()
  for(i in 1:nrow(df)){
    
    
    call <- 
      paste0("https://gtexportal.org/rest/v1/association/metasoft?variantId=",
             df$SNP[i], "_b38&gencodeId=", df$Gene[i], "&datasetId=gtex_v8")
    
    get_eqtl <- GET(call)
    get_eqtl_text <- httr::content(get_eqtl, "text", encoding = "UTF-8")
    if(get_eqtl_text != ""){
      gtex_list <- fromJSON(get_eqtl_text, flatten = FALSE)
      gtex_df = gtex_list$metasoft
      if(length(gtex_df) > 0){
        gtex_df = do.call(data.frame, gtex_df)
        gtex_df = gtex_df[, c("datasetId", "gencodeId",  "variantId",  "metaP" , 
                              colnames(gtex_df)[! colnames(gtex_df) %in% 
                                                  c("datasetId", "gencodeId", 
                                                    "metaP" , "variantId")])]
      } else{
        gtex_df = t(data.frame(c("gtex_v8", as.character(df$Gene[i]), 
                                 as.character(df$SNP[i]), rep(NA, 50)), 
                               stringsAsFactors = F))
      }
      colnames(gtex_df) = 
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
                       'Heart_Left_Ventricle', 'Kidney_Cortex', 'Liver', 'Lung', 
                       'Minor_Salivary_Gland', 'Muscle_Skeletal', 
                       'Nerve_Tibial', 
                       'Ovary', 'Pancreas', 'Pituitary', 'Prostate', 
                       'Skin_Not_Sun_Exposed_Suprapubic', 
                       'Skin_Sun_Exposed_Lower_leg', 
                       'Small_Intestine_Terminal_Ileum', 'Spleen', 'Stomach', 
                       'Testis', 
                       'Thyroid', 'Uterus', 'Vagina', 'Whole_Blood'), each=4),
                 rep(c(".mValue", ".nes", ".pValue", ".se"), 49)))
      out_df = rbind(out_df, gtex_df)
    } 
  }
  if(p_only) out_df = out_df[, grepl('Id|metaP|pValue', colnames(out_df))]
  
  return(out_df)
}
