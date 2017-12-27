# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Transcript < Baseurl
      @ignore = []
      @add_info = [:gene_id, :gene_name, :transcript_id]

      def self.identifier(linecnt) 
        linecnt
      end

      def self.gene_id
        return cosmicgeneid_relation(@row.gene_id)
      end
      
      def self.gene_name
        return genename_relation(@row.gene_name)
      end
      
      def self.transcript_id
        return genesymbol_relation(@row.transcript_id)
      end

      def self.use_prefix
        prefix =[
          CosmicRdf::PREFIX[:cosmicgene],
        ]
      end

      def self.rdf_catalog
        header = <<'EOS'
transcript:
    a dcat:Dataset ;
    dct:title CosmicTranscripts  ;
    rdfs:label "cosmic transcripts" ;
    dcat:keyword "transcripts" ;
    dcat:distribution "CosmicTranscripts.tsv.gz" ;
    dcterms:language lang:en ;
    .
EOS
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
