# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Fusion < Baseurl
      @ignore = []
      @add_info = [:sample_id]
      
      def self.identifier(linecnt)
        linecnt
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
fusion:
    a dcat:Dataset ;
    dct:title CosmicFusionExport  ;
    rdfs:label "gene fusion mutation data" ;
    dcat:keyword "fusion" ;
    dcat:distribution "CosmicFusionExport.tsv.gz" ;
    dcterms:language lang:en ;
    .
EOS
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
