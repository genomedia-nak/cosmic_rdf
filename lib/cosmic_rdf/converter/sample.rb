# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Sample < Baseurl
      @ignore = []
      @add_info = [:age, :gender, :sample_name, :sample_id]

      def self.identifier(linecnt)
        @row.sample_id
      end

      def self.sample_id
        #return "  dcterms:identifier \"#{@row.sample_id}\" ."
        return  "  #{@predicate}samp_ld [\n" +
                "    dcat:identifier \"COSS#{@row.sample_id}\";\n" +
                "    dcat:title \"COSMIC sample ID\"" +
                "    rdfs:seeAlso <#{CosmicRdf::URIs[:sample]}#{@row.sample_id}>\n" +
                "  ];"
      end

      def self.gender
        disp = "unknown "
        disp = "female" if @row.gender == 'f'
        disp = "man" if @row.gender == 'm'
        # return disp
        "  dbp:gender \"#{disp}\"; \n"
      end

      def self.sample_name
        return tcga_sample_relation(@row.sample_name)
      end

      def self.age
        rdf_age = nil
        rdf_age = "  foaf:age #{@row.age};" if @row.age != nil && @row.age =~ /^[0-9]+$/
        return rdf_age
      end

      def self.use_prefix
        prefix =[
        ]
      end
      
      def self.rdf_catalog
        header = <<'EOS'
s:
  a dcat:Dataset ;
  dcat:title "COSMIC SAMPLE" ;
  rdfs:label "cosmic sample" ;
  dcat:keyword "cancer","tumor" ,"mutation" ;
  dcat:distribution "CosmicSample.tsv.gz" ;
  dcat:language lang:en ;
  .
EOS
      end
      
    end
  end
end