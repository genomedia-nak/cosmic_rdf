# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Mutation < Baseurl
      @ignore    = []
      @add_info  = [:gene_name, :accession_number, :hgnc_id, :sample_id, :mutation_id, :pmid, :study_id]

      def self.identifier(linecnt)
        linecnt
      end

      def self.gene_name
        genename_relation(@row.gene_name)
      end

      def self.accession_number
        genesymbol_relation(@row.accession_number)
      end

      def self.hgnc_id
        hgnc_relation(@row.hgnc_id)
      end
      
      def self.sample_id
        sampleid_relation(@row.sample_id)
      end
      
      def self.mutation_id
        mutationid_relation(@row.mutation_id)
      end
      
      def self.pmid
        pmid_relation(@row.pmid)
      end

      def self.study_id
        studyid_relation(@row.study_id)
      end


      def self.use_prefix
        prefix =[
          CosmicRdf::PREFIX[:cosmicgene],
          CosmicRdf::PREFIX[:sample],
          CosmicRdf::PREFIX[:mutation],
          CosmicRdf::PREFIX[:study],
        ]
      end

      def self.rdf_catalog
        header = <<'EOS'
mt:
    a dcat:Dataset ;
    dcat:title "COSMIC MUTATION" ;
    rdfs:label "cosmic mutation" ;
    dcat:keyword "cancer","tumor" ,"mutation" ;
    dcat:distribution "CosmicMutantExport.tsv.gz" ;
    dcat:language lang:en ;
    .
EOS
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
