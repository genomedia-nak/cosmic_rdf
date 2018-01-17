# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Breakpoint < Baseurl
      @ignore = []
      @add_info = [:mutation_id]

      def self.identifier(linecnt)
        linecnt
      end

      def self.mutation_id
        # not relateion cosm-id
        # return mutationid_relation(@row.mutation_id)
        unless @row.mutation_id == nil
          "  #{@predicate}mutationid #{@row.mutation_id}"
        end
      end

      def self.use_prefix
        prefix =[
          ## CosmicRdf::PREFIX[:mutation],
        ]
      end

      def self.rdf_catalog
header = <<'EOS'
  breakpoint:
      a dcat:Dataset ;
      dct:title CosmicBreakpointsExport  ;
      rdfs:label "breakpoint data" ;
      dcat:keyword "breakpoint" ;
      dcat:distribution "CosmicBreakpointsExport.tsv.gz" ;
      dcat:language lang:en ;
      .
EOS
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
