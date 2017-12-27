# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Sample < Baseurl
      @ignore = [:gender]
      @add_info = [:sample_name]

      def self.identifier(linecnt)
        @row.sample_id
      end

      def self.gender()
        disp = "unknown "
        disp = "female" if @row.gender == 'f'
        disp = "man" if @row.gender == 'm'
        return disp
      end

      def self.sample_name
        return tcga_sample_relation(@row.sample_name)
      end

      def self.use_prefix
        prefix =[
          
        ]
      end

      def self.rdf_catalog
        header = <<'EOS'
sample:
  a dcat:Dataset ;
  dct:title "COSMIC SAMPLE" ;
  rdfs:label "cosmic sample" ;
  dcat:keyword "cancer","tumor" ,"mutation" ;
  dcat:distribution "CosmicSample.tsv.gz" ;
  dcterms:language lang:en ;
  .
EOS
      end
      
    end
  end
end