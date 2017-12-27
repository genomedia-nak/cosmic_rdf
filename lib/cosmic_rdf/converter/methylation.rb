# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Methylation < Baseurl
      @ignore = []
      @add_info = [:gene_name, :sample_id, :sample_name]

      def self.identifier(linecnt)
        linecnt
      end

      def self.gene_name
        genesymbol_relation(@row.gene_name)
      end
      
      def self.sample_id
        sampleid_relation(@row.sample_id)
      end

      def self.sample_name
        tcga_sample_relation(@row.sample_name)
      end
      def self.use_prefix
        prefix =[
          CosmicRdf::PREFIX[:cosmicgene],
          CosmicRdf::PREFIX[:sample],
        ]
      end
      def self.rdf_catalog
        header = <<'EOS'
methylation:
    a dcat:Dataset ;
    dct:title CosmicCompleteDifferentialMethylation  ;
    rdfs:label "TCGA Level 3 methylation data" ;
    dcat:keyword "Methylation", "TCGA" ;
    dcat:distribution "CosmicCompleteDifferentialMethylation.tsv.gz" ;
    dcterms:language lang:en ;
    .
EOS
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
