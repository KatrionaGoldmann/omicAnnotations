% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gtex_eqtl.R
\name{gtex_eqtl}
\alias{gtex_eqtl}
\title{Multi-tissue eqtl}
\usage{
gtex_eqtl(
  genes = c("CYP26B1"),
  snps = c("chr2_72209800_G_A"),
  gene_snp_pairs = c(),
  p_only = TRUE,
  gencodeIDs = FALSE
)
}
\arguments{
\item{genes}{A list of gene names in format genecode IDs}

\item{snps}{SNPs. In format chr11_66561248_T_C}

\item{gene_snp_pairs}{A data frame of gene-snp pairs with genes in the first
column and snps in the second}

\item{p_only}{Whether to keep only the p-value statistics}
}
\description{
Multi-tissue eqtl
}
