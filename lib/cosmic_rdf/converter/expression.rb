# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Expression < Baseurl
      @ignore = []
      @add_info = [:sample_id]

      def self.identifier(linecnt)
        @row.sample_id
      end
      
      def self.sample_id
        return sampleid_relation(@row.sample_id)
      end

      def self.use_prefix
        prefix =[
          CosmicRdf::PREFIX[:sample],
        ]
      end

      def self.rdf_catalog
        header = <<'EOS'
expression:
    a dcat:Dataset ;
    dct:title CosmicCompleteGeneExpression  ;
    rdfs:label "gene expression level 3 data from the TCGA portal" ;
    dcat:keyword "cna", "copy number" ;
    dcat:distribution "CosmicCompleteGeneExpression.tsv.gz" ;
    dcterms:language lang:en ;
    .
EOS
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
