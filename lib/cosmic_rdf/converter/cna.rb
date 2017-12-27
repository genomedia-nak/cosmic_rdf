# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Cna < Baseurl
      @ignore = []
      @add_info = [:gene_id, :gene_name, :sample_id]

      def self.identifier(linecnt)
        linecnt
      end

      def self.gene_id
        return cosmicgeneid_relation(@row.gene_id)
      end
      
      def self.gene_name
        return genename_relation(@row.gene_name)
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
        header = <<'EOS'
cna:
    a dcat:Dataset ;
    dct:title CosmicCompleteCNA  ;
    rdfs:label "cosmic copy number abberations" ;
    dcat:keyword "cna", "copy number" ;
    dcat:distribution "CosmicCompleteCNA.tsv.gz" ;
    dcterms:language lang:en ;
    .
EOS
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
