# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Resistance < Baseurl
      @ignore = []
      @add_info = [:sample_id, :gene_name, :mutation_id]

      def self.identifier(linecnt)
        linecnt
      end

      def self.sample_id
        return sampleid_relation(@row.sample_id)
      end

      def self.gene_name
        return genename_relation(@row.gene_name)
      end

      def self.mutation_id
        return mutationid_relation(@row.mutation_id)
      end

      def self.somatic_status
        status = 
          case @row.somatic_status
          when 0; "Not specified"
          when 1; "Confirmed somatic variant"
          when 2; "Reported in another cancer sample as somatic"
          when 5; "Variant of unknown origin"
          when 7; "Systematic screen"
          when 21; "Likely cancer causing"
          when 22; "Possible cancer causing"
          when 23; "Unknown consequence"
          when 25; "To be decided"
          when 50; "Verified"
          when 51; "Unverified"
          when 52; "Unverified - SNP6"
          else nil
          end
        return "  somatic_status: #{status} ;" unless status == nil
      end

      def self.use_prefix
        prefix =[
          CosmicRdf::PREFIX[:cosmicgene],
          CosmicRdf::PREFIX[:sample],
          CosmicRdf::PREFIX[:mutation],
        ]
      end

      def self.rdf_catalog
        header = <<'          END'
          fusion:
              a dcat:Dataset ;
              dct:title CosmicResistanceMutations  ;
              rdfs:label "known to confer drug resistance" ;
              dcat:keyword "resistance", "drug resistance" ;
              dcat:distribution "CosmicResistanceMutations.tsv.gz" ;
              dcterms:language lang:en ;
              .
          END
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
