module CosmicRdf
  SFTP_HOST = 'sftp-cancer.sanger.ac.uk'.freeze

  LATEST_VERSION = 82
  AVAILABLE_VERSIONS = [*72..LATEST_VERSION].freeze

  DEFAULT_GRCH = 38
  AVAILABLE_GRCH = [37, DEFAULT_GRCH].freeze

  FILES = {
    sample:         'CosmicSample.tsv.gz',
    mutation:       'CosmicMutantExport.tsv.gz',
    cna:            'CosmicCompleteCNA.tsv.gz',
    methylation:    'CosmicCompleteDifferentialMethylation.tsv.gz',
    expression:     'CosmicCompleteGeneExpression.tsv.gz',
    fusion:         'CosmicFusionExport.tsv.gz',
    hgnc:           'CosmicHGNC.tsv.gz',
    ncv:            'CosmicNCV.tsv.gz',
    resistance:     'CosmicResistanceMutations.tsv.gz',
    struct:         'CosmicStructExport.tsv.gz',
    transcript:     'CosmicTranscripts.tsv.gz',
    breakpoint:     'CosmicBreakpointsExport.tsv.gz',
    target:         'CosmicCompleteTargetedScreensMutantExport.tsv.gz',
    ##ploidy:         'ascat_acf_ploidy.tsv',
    ##fasta:          'All_COSMIC_Genes.fasta.gz',
    ##classification: 'classification.csv',
    ##vcf_coding:     'VCF/CosmicCodingMuts.vcf.gz',
    ##vcf_noncoding:  'VCF/CosmicNonCodingVariants.vcf.gz'
  }.freeze

  RDFS = {
    breakpoint:     'CosmicBreakpointsExport.ttl',
    cna:            'CosmicCompleteCNA.ttl',
    methylation:    'CosmicCompleteDifferentialMethylation.ttl',
    expression:     'CosmicCompleteGeneExpression.ttl',
    fusion:         'CosmicFusionExport.ttl',
    hgnc:           'CosmicHGNC.ttl',
    mutation:       'CosmicMutantExport.ttl',
    ncv:            'CosmicNCV.ttl',
    resistance:     'CosmicResistanceMutations.ttl',
    sample:         'CosmicSample.ttl',
    struct:         'CosmicStructExport.ttl',
    transcript:     'CosmicTranscripts.ttl',
    target:         'CosmicCompleteTargetedScreensMutantExport.ttl'
  }.freeze

  URIs = {
    sample: 'http://cancer.sanger.ac.uk/cosmic/sample/overview?id=',
    mutation: 'http://hoge.huga/cosmic/mutation#',
    target: 'http://hoge.huga/cosmic/target#',
    mutationid: 'http://cancer.sanger.ac.uk/cosmic/mutation/overview?id=',
    cna: 'http://hoge.huga/cosmic/cnaid#',
    ncv: 'http://hoge.huga/cosmic/ncvid#',
    hgnc: 'http://cancer.sanger.ac.uk/cosmic/gene/analysis?ln=',
    genedirect: 'http://cancer.sanger.ac.uk/cosmic/gene/analysis?ln=',
    fusion: 'http://hoge.huga/cosmic/fusionid#',
    expression: 'http://hoge.huga/cosmic/expressionid#',
    resistance: 'http://hoge.huga/cosmic/resistanceid#',
    methylation: 'http://hoge.huga/cosmic/methylationid#',
    breakpoint: 'http://hoge.huga/cosmic/breakpointsid#',
    struct: 'http://hoge.huga/cosmic/structid#',
    transcript: 'http://hoge.huga/cosmic/transcriptid#',
    study: 'http://cancer.sanger.ac.uk/cosmic/study/overview?study_id=',
    cancerDigital: 'http://cancer.digitalslidearchive.net/index_mskcc.php?slide_name=',
    cosmicgene: 'http://identifiers.org/cosmic/',
    refseq: 'http://identifiers.org/refseq/',
    hgncurl: 'http://identifiers.org/hgnc/',
    pubmed: 'http://identifiers.org/pubmed/',
    ensembl: 'http://identifiers.org/ensembl/',
    ncbigene: 'http://identifiers.org/ncbigene/'
  }.freeze

  PREFIX = {
    sample: "@prefix sample:<#{URIs[:sample]}> .",
    mutation: "@prefix mutation:<#{URIs[:mutationid]}> .",
    target: "@prefix target:<#{URIs[:target]}> .",
    cna: "@prefix cna:<#{URIs[:cna]}> .",
    ncv: "@prefix ncv:<#{URIs[:ncv]}> .",
    fusion: "@prefix fusion:<#{URIs[:fusion]}> .",
    expression: "@prefix expression:<#{URIs[:expression]}> .",
    resistance: "@prefix resistance:<#{URIs[:resistance]}> .",
    methylation: "@prefix methylation:<#{URIs[:methylation]}> .",
    breakpoints: "@prefix breakpoints:<#{URIs[:breakpoints]}> .",
    study: "@prefix study:<#{URIs[:study]}> .",
    hgnc: "@prefix hgnc:<#{URIs[:cosmicgene]}> .",
    hgncurl: "@prefix hgnc:<#{URIs[:hgnc]}> .",
    struct: "@prefix struct:<#{URIs[:struct]}> .",
    transcript: "@prefix transcript:<#{URIs[:transcript]}> .",
    cosmicgene: "@prefix cosmicgene:<#{URIs[:cosmicgene]}> .",
    ncbigene: "@prefix  ncbigene:<#{URIs[:ncbigene]}> .",

  }.freeze

  PREDICATE_PREFIX ={
    sample: '@prefix s:<http://hoge.huga/cosmic/sample/> .',
    mutation: '@prefix mt:<http://hoge.huga/cosmic/mutation/> .',
    target: '@prefix t:<http://hoge.huga/cosmic/target/> .',
    cna: '@prefix c:<http://hoge.huga/cosmic/cna#> .',
    ncv: '@prefix n:<http://hoge.huga/cosmic/ncv#> .',
    fusion: '@prefix f:<http://hoge.huga/cosmic/fusion#> .',
    expression: '@prefix e:<http://hoge.huga/cosmic/expression#> .',
    resistance: '@prefix r:<http://hoge.huga/cosmic/resistance#> .',
    methylation: '@prefix me:<http://hoge.huga/cosmic/methylation#> .',
    breakpoint: '@prefix b:<http://hoge.huga/cosmic/breakpoints#> .',
    hgnc: '@prefix h:<http://hoge.huga/cosmic/hgnc#> .',
    struct: '@prefix st:<http://hoge.huga/cosmic/struct#> .',
    transcript: '@prefix t:<http://hoge.huga/cosmic/transcript#> .',
  }.freeze

end
