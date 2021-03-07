geneAnnotations
===============

This package annotated gene names and annotations.

Summarising Genes
-----------------

For example for the entire gene summary:

    gene_df <- gene_summary(genes=c("FMOD", "FGF1", "SLAMF6"), diseases="C20")

    ## [1] "Annotating EMR's favourites..."
    ## [1] "Getting gene summaries..."
    ## [1] "Finding associated diseases..."

    kable(gene_df, format = "markdown", row.names = FALSE)

<table>
<colgroup>
<col style="width: 0%" />
<col style="width: 2%" />
<col style="width: 74%" />
<col style="width: 22%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Gene</th>
<th style="text-align: left;">description</th>
<th style="text-align: left;">summary</th>
<th style="text-align: left;">Associated_diseases</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">FMOD</td>
<td style="text-align: left;">fibromodulin</td>
<td style="text-align: left;">Fibromodulin belongs to the family of small interstitial proteoglycans. The encoded protein possesses a central region containing leucine-rich repeats with 4 keratan sulfate chains, flanked by terminal domains containing disulphide bonds. Owing to the interaction with type I and type II collagen fibrils and in vitro inhibition of fibrillogenesis, the encoded protein may play a role in the assembly of extracellular matrix. It may also regulate TGF-beta activities by sequestering TGF-beta into the extracellular matrix. Sequence variations in this gene may be associated with the pathogenesis of high myopia. Alternative splicing results in multiple transcript variants. [provided by RefSeq, Jun 2013]</td>
<td style="text-align: left;">Chronic Lymphocytic Leukemia; Lymphoma; B-Cell Lymphomas; Malignant lymphoma, lymphocytic, intermediate differentiation, diffuse; Adult Lymphoma; Childhood Lymphoma</td>
</tr>
<tr class="even">
<td style="text-align: left;">FGF1</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;">Rheumatoid Arthritis; Asthma; Acquired Immunodeficiency Syndrome; Diabetes Mellitus, Insulin-Dependent; Multiple Myeloma; Multiple Sclerosis; HIV Encephalopathy; HIV encephalitis; Thyroid associated opthalmopathies</td>
</tr>
<tr class="odd">
<td style="text-align: left;">SLAMF6</td>
<td style="text-align: left;">SLAM family member 6</td>
<td style="text-align: left;">The protein encoded by this gene is a type I transmembrane protein, belonging to the CD2 subfamily of the immunoglobulin superfamily. This encoded protein is expressed on Natural killer (NK), T, and B lymphocytes. It undergoes tyrosine phosphorylation and associates with the Src homology 2 domain-containing protein (SH2D1A) as well as with SH2 domain-containing phosphatases (SHPs). It functions as a coreceptor in the process of NK cell activation. It can also mediate inhibitory signals in NK cells from X-linked lymphoproliferative patients. Alternative splicing results in multiple transcript variants encoding distinct isoforms.[provided by RefSeq, May 2010]</td>
<td style="text-align: left;">Graves Disease; Lupus Erythematosus, Systemic; Autoimmune Diseases; Lupus Erythematosus; HIV Infections; Chronic Lymphocytic Leukemia; Lymphoma; X-Linked Lymphoproliferative Disorder</td>
</tr>
</tbody>
</table>

Publications
------------

You can check for publications focusing on genes with given terms.
Either using `associated_publications`:

    gene_pubs <- associated_publications(genes=c("FGF1"), 
                                         keywords=c("rheumatoid"), 
                                         split="OR", 
                                         verbose=TRUE)

    kable(gene_pubs, format = "markdown", row.names=FALSE)

<table>
<colgroup>
<col style="width: 0%" />
<col style="width: 99%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Gene</th>
<th style="text-align: left;">Publications</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">FGF1</td>
<td style="text-align: left;">The transcriptomic profiling of SARS-CoV-2 compared to SARS, MERS, EBOV, and H1N1.; sICAM-1 as potential additional parameter in the discrimination of the Sjögren syndrome and non-autoimmune sicca syndrome: a pilot study.; [Effects of Huatan Tongluo Recipe on IL-1β-induced Proliferation of Rheumatoid Arthritis Synovial Fibroblasts and the Production of TNF-α and aFGF].; Fibroblast growth factors, fibroblast growth factor receptors, diseases, and drugs.; VEGF, FGF1, FGF2 and EGF gene polymorphisms and psoriatic arthritis.; Transcription factor Ets-1 regulates fibroblast growth factor-1-mediated angiogenesis in vivo: role of Ets-1 in the regulation of the PI3K/AKT/MMP-1 pathway.; Induction of RANKL expression and osteoclast maturation by the binding of fibroblast growth factor 2 to heparan sulfate proteoglycan on rheumatoid synovial fibroblasts.; Acidic fibroblast growth factor in synovial cells.; Characterization of tissue outgrowth developed in vitro in patients with rheumatoid arthritis: involvement of T cells in the development of tissue outgrowth.; Fibroblast growth factor-1 (FGF-1) enhances IL-2 production and nuclear translocation of NF-kappaB in FGF receptor-bearing Jurkat T cells.; A novel in vitro assay for human angiogenesis.; Expression and functional expansion of fibroblast growth factor receptor T cells in rheumatoid synovium and peripheral blood of patients with rheumatoid arthritis.; Detection of T cells responsive to a vascular growth factor in rheumatoid arthritis.; Coexpression of phosphotyrosine-containing proteins, platelet-derived growth factor-B, and fibroblast growth factor-1 in situ in synovial tissues of patients with rheumatoid arthritis and Lewis rats with adjuvant or streptococcal cell wall arthritis.; Platelet-derived growth factors and heparin-binding (fibroblast) growth factors in the synovial tissue pathology of rheumatoid arthritis.; Fibroblast growth factors: from genes to clinical applications.; Production of platelet derived growth factor B chain (PDGF-B/c-sis) mRNA and immunoreactive PDGF B-like polypeptide by rheumatoid synovium: coexpression with heparin binding acidic fibroblast growth factor-1.; Detection of high levels of heparin binding growth factor-1 (acidic fibroblast growth factor) in inflammatory arthritic joints.</td>
</tr>
</tbody>
</table>

Or `gene_summary`:

    gene_df <- gene_summary(genes=c("FGF1"), 
                            associated_diseases = FALSE,
                            gene_description=FALSE, 
                            publications = TRUE)

    ## [1] "Annotating EMR's favourites..."
    ## [1] "Getting publications from PubMed..."

    kable(gene_df, format = "markdown", row.names=FALSE)

<table>
<colgroup>
<col style="width: 0%" />
<col style="width: 99%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Gene</th>
<th style="text-align: left;">Publications</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">FGF1</td>
<td style="text-align: left;">sICAM-1 as potential additional parameter in the discrimination of the Sjögren syndrome and non-autoimmune sicca syndrome: a pilot study.; Oligodendroglial fibroblast growth factor receptor 1 gene targeting protects mice from experimental autoimmune encephalomyelitis through ERK/AKT phosphorylation.; Dysregulation of pathways involved in the processing of cancer and microenvironment information in MCA + TPA transformed C3H/10T1/2 cells.; Cutaneous gene expression by DNA microarray in murine sclerodermatous graft-versus-host disease, a model for human scleroderma.; Angiocidal effect of Cyclosporin A: a new therapeutic approach for pathogenic angiogenesis.; Lack of FGF-1 overexpression during autoimmune nephritis in the kidneys of MRL lpr/lpr mice.; Cloning and characterization of a novel upstream untranslated exon of the mouse Fgf-1 gene.; Cloning and characterization of the mouse Fgf-1 gene.; Environmental influences on fatty acid composition of membranes from autoimmune MRL lpr/lpr mice.; Costimulation of human CD4+ T cells by fibroblast growth factor-1 (acidic fibroblast growth factor).</td>
</tr>
</tbody>
</table>

Enriched pathways
-----------------

Looks for enriched pathways with gene sets using
[enrichR](https://maayanlab.cloud/Enrichr/).

    lymphoid_pathways <- enriched_pathways(
      genes=c("LAMP5", "LINC01480", "FAM92B", "SLAMF6", "CEP128",
              "FKBP11", "CRTAM", "ISG20", "ZBP1", "TMEM229B",
              "FAM46C", "XBP1", "APOBEC3G", "TNIK", "CD2", "SP140",
              "ACOXL", "PTPRCAP", "PDCD1", "KCNN3", "GZMK",
              "IGFLR1", "SH2D2A", "PIM2", "TPST2"),
      libraries = c('Pathways'),
      check_for_updates = FALSE)

Plots

    lymphoid_pathways$plot

![](ReadMe_files/figure-markdown_strict/unnamed-chunk-7-1.png)
