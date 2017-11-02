module CosmicRdf
  SFTP_HOST = 'sftp-cancer.sanger.ac.uk'.freeze

  LATEST_VERSION = 82
  AVAILABLE_VERSIONS = [*72..LATEST_VERSION].freeze

  DEFAULT_GRCH = 38
  AVAILABLE_GRCH = [37, DEFAULT_GRCH].freeze

  FILES = {
    fasta:          'All_COSMIC_Genes.fasta.gz',
    breakpoint:     'CosmicBreakpointsExport.tsv.gz',
    cna:            'CosmicCompleteCNA.tsv.gz',
    methylation:    'CosmicCompleteDifferentialMethylation.tsv.gz',
    expression:     'CosmicCompleteGeneExpression.tsv.gz',
    fusion:         'CosmicFusionExport.tsv.gz',
    hgnc:           'CosmicHGNC.tsv.gz',
    mutation:       'CosmicMutantExport.tsv.gz',
    ncv:            'CosmicNCV.tsv.gz',
    resistance:     'CosmicResistanceMutations.tsv.gz',
    sample:         'CosmicSample.tsv.gz',
    struct:         'CosmicStructExport.tsv.gz',
    transcript:     'CosmicTranscripts.tsv.gz',
    ploidy:         'ascat_acf_ploidy.tsv',
    classification: 'classification.csv',
    vcf_coding:     'VCF/CosmicCodingMuts.vcf.gz',
    vcf_noncoding:  'VCF/CosmicNonCodingVariants.vcf.gz'
  }.freeze
end
