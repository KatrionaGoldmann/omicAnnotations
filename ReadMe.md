geneAnnotations
===============

This package annotated gene names and annotations.

For example for the entire gene summary:

    gene_df <- gene_summary(genes=c("MS4A1", "FGF1", "SLAMF6"), diseases="C20")

    ## [1] "Annotating EMR's favourites..."
    ## [1] "Getting gene summaries..."
    ## [1] "Finding associated diseases..."

    kable(gene_df, format = "markdown")

<table>
<colgroup>
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 12%" />
<col style="width: 86%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: left;">Gene</th>
<th style="text-align: left;">description</th>
<th style="text-align: left;">summary</th>
<th style="text-align: left;">Associated_diseases</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">MS4A1</td>
<td style="text-align: left;">MS4A1</td>
<td style="text-align: left;">membrane spanning 4-domains A1</td>
<td style="text-align: left;">This gene encodes a member of the membrane-spanning 4A gene family. Members of this nascent protein family are characterized by common structural features and similar intron/exon splice boundaries and display unique expression patterns among hematopoietic cells and nonlymphoid tissues. This gene encodes a B-lymphocyte surface molecule which plays a role in the development and differentiation of B-cells into plasma cells. This family member is localized to 11q12, among a cluster of family members. Alternative splicing of this gene results in two transcript variants which encode the same protein. [provided by RefSeq, Jul 2008]</td>
<td style="text-align: left;">Common Variable Immunodeficiency; Acquired Hypogammaglobulinemia; Immunoglobulin Deficiency, Late-Onset; Lymphoma; Immune thrombocytopenic purpura; Immunologic Deficiency Syndromes; Lymphopenia; Rheumatoid Arthritis; Autoimmune Diseases; Burkitt Lymphoma; Hodgkin Disease; Chronic Lymphocytic Leukemia; Acute lymphocytic leukemia; Lupus Erythematosus, Systemic; Lymphoma, Follicular; Lymphoma, Non-Hodgkin; Lymphoproliferative Disorders; Multiple Myeloma; Multiple Sclerosis; B-Cell Lymphomas; Diffuse Large B-Cell Lymphoma; T-Cell Lymphoma; Adult Non-Hodgkin Lymphoma; Childhood Non-Hodgkin Lymphoma; Adult Diffuse Large B-Cell Lymphoma; Adult Lymphoma; Childhood Lymphoma; Precursor Cell Lymphoblastic Leukemia Lymphoma; Mantle cell lymphoma; Lymphoma, Non-Hodgkin, Familial; Neuromyelitis Optica; Lymphoma, Large-Cell, Follicular; Adult Burkitt Lymphoma; Childhood Burkitt Lymphoma; Malignant lymphoma, lymphocytic, intermediate differentiation, diffuse; Pemphigus; Peripheral T-Cell Lymphoma; Childhood Acute Lymphoblastic Leukemia; Waldenstrom Macroglobulinemia; Trisomy 12; Classical Hodgkin’s Lymphoma; Diabetes Mellitus, Insulin-Dependent; Membranous glomerulonephritis; Precursor B-cell lymphoblastic leukemia; Hairy Cell Leukemia; Primary Sjögren’s syndrome; Adult Hodgkin Lymphoma; Childhood Hodgkin Lymphoma; Thyroid associated opthalmopathies; Mediastinal (Thymic) Large B-Cell Lymphoma; Marginal Zone B-Cell Lymphoma; IGA Glomerulonephritis; Lymphoid leukemia; Lupus Nephritis; Severe Combined Immunodeficiency; Autoimmune thrombocytopenia; Mucosa-Associated Lymphoid Tissue Lymphoma; Primary central nervous system lymphoma; Chronic graft-versus-host disease; Nodular Lymphocyte Predominant Hodgkin Lymphoma; Adult Classical Hodgkin Lymphoma; Plasmablastic lymphoma; Granulomatosis with polyangiitis; Autoimmune hemolytic anemia; Graft-vs-Host Disease; Immune System Diseases; Leukemia, T-Cell; Adult T-Cell Lymphoma/Leukemia; Monoclonal Gammopathy of Undetermined Significance; Pemphigus Vulgaris; Hypogammaglobulinemia; Nodular Sclerosis Classical Hodgkin Lymphoma; Ki-1+ Anaplastic Large Cell Lymphoma; Chronic lymphocytic leukaemia refractory; Splenic Marginal Zone B-Cell Lymphoma; Lupus Erythematosus; Post-transplant lymphoproliferative disorder; Low grade B-cell lymphoma; Mixed cryoglobulinemia; Multiple Sclerosis, Relapsing-Remitting; Recurrent Chronic Lymphoid Leukemia; Small Lymphocytic Lymphoma; Multi-centric Castleman’s Disease; Refractory Follicular Lymphoma; Familial primary gastric lymphoma; T-Cell Large Granular Lymphocyte Leukemia; Leukemia, B-Cell; Burkitt Leukemia; Asthma; Chronic granulomatous disease; Hay fever; HIV Infections; Infectious Mononucleosis; Prolymphocytic Leukemia; Myasthenia Gravis; Mycosis Fungoides; Bullous pemphigoid; Plasmacytoma; Serum Sickness; Immunoblastic Large-Cell Lymphoma; Lymphoma, T-Cell, Cutaneous; Lymphoma, AIDS-Related; Immunoglobulin A deficiency (disorder); Diabetes, Autoimmune; Autoimmune Chronic Hepatitis; Pemphigus Foliaceus; Primary amyloidosis; Peripheral demyelinating neuropathy; Evans syndrome; Adult Diffuse Large Cell Lymphoma; Childhood Diffuse Large Cell Lymphoma; Childhood Burkitt Leukemia; Adult Burkitt Leukemia; Intraocular Lymphoma; Malignant lymphoma - lymphoplasmacytic; Angioendotheliomatosis; Seropositive rheumatoid arthritis; Leukemia, Prolymphocytic, B-Cell; Humoral immune defect; Nasal and nasal-type NK/T-cell lymphoma; Multiple Sclerosis, Primary Progressive; Non-Hodgkin’s lymphoma refractory; Diffuse large B-cell lymphoma recurrent; Diffuse large B-cell lymphoma refractory; B Lymphoblastic Lymphoma; Hepatic lymphoma; Plasma cell dyscrasia; Monoclonal Gammapathies; Primary cutaneous B-cell lymphoma; Primary cutaneous diffuse large cell B-cell lymphoma; Primary Effusion Lymphoma; T-cell/histiocyte rich large B-cell lymphoma; Autoimmune Lymphoproliferative Syndrome; Adult Anaplastic Large Cell Lymphoma; Childhood Anaplastic Large Cell Lymphoma; Gastric Mucosa-Associated Lymphoid Tissue Lymphoma; B-cell lymphoma unclassifiable with features intermediate between classical Hodgkin lymphoma and diffuse large B-cell lymphoma; Malignant lymphoma in remission; Microscopic Polyarteritis; T-Cell Prolymphocytic Leukemia; Anti-Neutrophil Cytoplasmic Antibody-Associated Vasculitis; X-linked immunodeficiency with magnesium defect, Epstein-Barr virus infection and neoplasia; Refractory Childhood Acute Lymphoblastic Leukemia; Immunoglobulin G4-Related Disease; Recurrent Lymphoma</td>
</tr>
<tr class="even">
<td style="text-align: left;">FGF1</td>
<td style="text-align: left;">FGF1</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;">Rheumatoid Arthritis; Asthma; Acquired Immunodeficiency Syndrome; Diabetes Mellitus, Insulin-Dependent; Multiple Myeloma; Multiple Sclerosis; HIV Encephalopathy; HIV encephalitis; Thyroid associated opthalmopathies</td>
</tr>
<tr class="odd">
<td style="text-align: left;">SLAMF6</td>
<td style="text-align: left;">SLAMF6</td>
<td style="text-align: left;">SLAM family member 6</td>
<td style="text-align: left;">The protein encoded by this gene is a type I transmembrane protein, belonging to the CD2 subfamily of the immunoglobulin superfamily. This encoded protein is expressed on Natural killer (NK), T, and B lymphocytes. It undergoes tyrosine phosphorylation and associates with the Src homology 2 domain-containing protein (SH2D1A) as well as with SH2 domain-containing phosphatases (SHPs). It functions as a coreceptor in the process of NK cell activation. It can also mediate inhibitory signals in NK cells from X-linked lymphoproliferative patients. Alternative splicing results in multiple transcript variants encoding distinct isoforms.[provided by RefSeq, May 2010]</td>
<td style="text-align: left;">Graves Disease; Lupus Erythematosus, Systemic; Autoimmune Diseases; Lupus Erythematosus; HIV Infections; Chronic Lymphocytic Leukemia; Lymphoma; X-Linked Lymphoproliferative Disorder</td>
</tr>
</tbody>
</table>

Or to include publications

    gene_df <- gene_summary(genes=c("MS4A1", "FGF1", "SLAMF6"), 
                            associated_diseases = FALSE,
                            publications = TRUE)

    ## [1] "Annotating EMR's favourites..."
    ## [1] "Getting gene summaries..."
    ## [1] "Getting publications from PubMed..."

    kable(gene_df, format = "markdown")

<table>
<colgroup>
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 1%" />
<col style="width: 36%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: left;">Gene</th>
<th style="text-align: left;">description</th>
<th style="text-align: left;">summary</th>
<th style="text-align: left;">Publications</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">MS4A1</td>
<td style="text-align: left;">MS4A1</td>
<td style="text-align: left;">membrane spanning 4-domains A1</td>
<td style="text-align: left;">This gene encodes a member of the membrane-spanning 4A gene family. Members of this nascent protein family are characterized by common structural features and similar intron/exon splice boundaries and display unique expression patterns among hematopoietic cells and nonlymphoid tissues. This gene encodes a B-lymphocyte surface molecule which plays a role in the development and differentiation of B-cells into plasma cells. This family member is localized to 11q12, among a cluster of family members. Alternative splicing of this gene results in two transcript variants which encode the same protein. [provided by RefSeq, Jul 2008]</td>
<td style="text-align: left;">Identification of hub genes and therapeutic drugs in rheumatoid arthritis patients.; Transcriptome Sequencing Reveals Potential Roles of <i>ICOS</i> in Primary Sjögren’s Syndrome.; Noncanonical immunomodulatory activity of complement regulator C4BP(β-) limits the development of lupus nephritis.; Artery Tertiary Lymphoid Organs Control Multilayered Territorialized Atherosclerosis B-Cell Responses in Aged ApoE-/- Mice.; Genetic variation and coronary atherosclerosis in patients with systemic lupus erythematosus.; <sup>99m</sup>Tc-Labeled rituximab, a chimeric murine/human anti-CD20 monoclonal antibody; CD20 deficiency in humans results in impaired T cell-independent antibody responses.; Rituximab in relapsing Graves’ disease, a phase II study.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FGF1</td>
<td style="text-align: left;">FGF1</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;">sICAM-1 as potential additional parameter in the discrimination of the Sjögren syndrome and non-autoimmune sicca syndrome: a pilot study.; Oligodendroglial fibroblast growth factor receptor 1 gene targeting protects mice from experimental autoimmune encephalomyelitis through ERK/AKT phosphorylation.; Dysregulation of pathways involved in the processing of cancer and microenvironment information in MCA + TPA transformed C3H/10T1/2 cells.; Cutaneous gene expression by DNA microarray in murine sclerodermatous graft-versus-host disease, a model for human scleroderma.; Angiocidal effect of Cyclosporin A: a new therapeutic approach for pathogenic angiogenesis.; Lack of FGF-1 overexpression during autoimmune nephritis in the kidneys of MRL lpr/lpr mice.; Cloning and characterization of a novel upstream untranslated exon of the mouse Fgf-1 gene.; Cloning and characterization of the mouse Fgf-1 gene.; Environmental influences on fatty acid composition of membranes from autoimmune MRL lpr/lpr mice.; Costimulation of human CD4+ T cells by fibroblast growth factor-1 (acidic fibroblast growth factor).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">SLAMF6</td>
<td style="text-align: left;">SLAMF6</td>
<td style="text-align: left;">SLAM family member 6</td>
<td style="text-align: left;">The protein encoded by this gene is a type I transmembrane protein, belonging to the CD2 subfamily of the immunoglobulin superfamily. This encoded protein is expressed on Natural killer (NK), T, and B lymphocytes. It undergoes tyrosine phosphorylation and associates with the Src homology 2 domain-containing protein (SH2D1A) as well as with SH2 domain-containing phosphatases (SHPs). It functions as a coreceptor in the process of NK cell activation. It can also mediate inhibitory signals in NK cells from X-linked lymphoproliferative patients. Alternative splicing results in multiple transcript variants encoding distinct isoforms.[provided by RefSeq, May 2010]</td>
<td style="text-align: left;">Genome-wide association study in a Korean population identifies six novel susceptibility loci for rheumatoid arthritis.; Genetic Study in a Large Cohort Supported Different Pathogenesis of Graves’ Disease and Hashimoto’s Hypothyroidism.; Somatic mutations in clonally expanded cytotoxic T lymphocytes in patients with newly diagnosed rheumatoid arthritis.; Positive selection of type II collagen-reactive CD80<sup>high</sup> marginal zone B cells in DBA/1 mice.; Slamf6 negatively regulates autoimmunity.; Robust evidence for five new Graves’ disease risk loci from a staged genome-wide association analysis.; CD3-T cell receptor co-stimulation through SLAMF3 and SLAMF6 receptors enhances RORγt recruitment to the IL17A promoter in human T lymphocytes.; Increased expression of SLAM receptors SLAMF3 and SLAMF6 in systemic lupus erythematosus T lymphocytes promotes Th17 differentiation.; Regulation of NK cell activity by 2B4, NTB-A and CRACC.; NTB-A, a new activating receptor in T cells that regulates autoimmune disease.</td>
</tr>
</tbody>
</table>
