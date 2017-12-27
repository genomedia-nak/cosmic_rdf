# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Struct < Baseurl
      @ignore = []
      @add_info = [:mutation_id]

      def self.identifier(linecnt)
        linecnt
      end

      def self.mutation_id
        return mutationid_relation(@row.mutation_id)
      end

      def self.use_prefix
        prefix =[
          CosmicRdf::PREFIX[:mutation],
        ]
      end

      def self.rdf_catalog
        header = <<'          END'
          cna:
              a dcat:Dataset ;
              dct:title CosmicStruct ;
              rdfs:label "cosmic structural variants" ;
              dcat:keyword "structural variants" ;
              dcat:distribution "CosmicStructExport.tsv.gz" ;
              dcterms:language lang:en ;
              .
          END
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
