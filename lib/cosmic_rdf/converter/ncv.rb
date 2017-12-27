# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Ncv < Baseurl
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
          CosmicRdf::PREFIX[:cosmicgene],
          CosmicRdf::PREFIX[:sample],
        ]
      end

      def self.rdf_catalog
        header = <<'          END'
          sample:
              a dcat:Dataset ;
              dct:title CosmicNCV  ;
              rdfs:label "Non coding variants" ;
              dcat:keyword "ncv", "non-coding" ;
              dcat:distribution "CosmicNCV.tsv.gz" ;
              dcterms:language lang:en ;
              .
          END
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
