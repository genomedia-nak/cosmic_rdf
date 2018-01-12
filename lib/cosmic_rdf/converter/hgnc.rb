# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Hgnc < Baseurl
      @ignore = [:gene_name]
      @add_info = [:entrez_id, :hgnc_id]

      def self.identifier(linecnt)
        @row.gene_name
      end

      def self.entrez_id
        entrez_id_relation(@row.entrez_id)
      end

      def self.gene_name
        # relation at identifier
        return nil
      end
      
      def self.hgnc_id
        return hgnc_relation(@row.hgnc_id)
      end

      def self.use_prefix
        prefix =[
          CosmicRdf::PREFIX[:cosmicgene],
          CosmicRdf::PREFIX[:sample],
          CosmicRdf::PREFIX[:ncbigene],
          CosmicRdf::PREFIX[:hgnc],
        ]
      end

      def self.rdf_catalog
        header = <<'EOS'
hgnc:
  a dcat:Dataset ;
  dct:title CosmicHGNC  ;
  rdfs:label "relationship between the Cancer Gene Census, COSMIC ID, Gene Name, HGNC ID and Entrez ID." ;
  dcat:keyword "HGNC ID" ;
  dcterms:language lang:en ;
  .
EOS
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
