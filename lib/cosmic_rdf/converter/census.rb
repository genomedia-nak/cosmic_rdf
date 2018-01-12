# coding: utf-8

require 'cosmic_rdf/converter/baseurl'

module CosmicRdf
  module Converter
    class Census < Baseurl
      @ignore    = []
      @add_info  = [:gene_name, 
                    :entrez_id, 
                    :hallmark, 
                    :tissue,
                    :molecular_genetics,
                    :role,
                    :mutation_type,
                    #:other_germline,
      ]

      ABBREVIATIONS = { 
        'A' => 'Amplification' ,
        'AEL' => 'Acute eosinophilic leukemia' ,
        'AL' => 'Acute leukemia' ,
        'ALCL' => 'Anaplastic large-cell lymphoma' ,
        'ALL' => 'Acute lymphocytic leukemia' ,
        'AML' => 'Acute myelogenous leukemia' ,
        'AML*' => 'Acute myelogenous leukemia (primarily treatment associated)' ,
        'APL' => 'Acute promyelocytic leukemia' ,
        'B-ALL' => 'B-cell acute lymphocytic leukaemia' ,
        'B-CLL' => 'B-cell Lymphocytic leukemia' ,
        'B-NHL' => 'B-cell Non-Hodgkin Lymphoma' ,
        'CLL' => 'Chronic lymphatic leukemia' ,
        'CML' => 'Chronic myeloid leukemia' ,
        'CMML' => 'Chronic myelomonocytic leukemia' ,
        'CNS' => 'Central nervous system' ,
        'D' => 'Large deletion' ,
        'DFSP' => 'Dermatofibrosarcoma protuberans' ,
        'DLBL' => 'Diffuse large B-cell lymphoma' ,
        'DLCL' => 'Diffuse large-cell lymphoma' ,
        'Dom' => 'Dominant' ,
        'E' => 'Epithelial' ,
        'F' => 'Frameshift' ,
        'GIST' => 'Gastrointestinal stromal tumour' ,
        'JMML' => 'Juvenile myelomonocytic leukemia' ,
        'L' => 'Leukaemia/lymphoma' ,
        'M' => 'Mesenchymal' ,
        'MALT' => 'Mucosa-associated lymphoid tissue lymphoma' ,
        'MDS' => 'Myelodysplastic syndrome' ,
        'Mis' => 'Missense' ,
        'MLCLS' => 'Mediastinal large cell lymphoma with sclerosis' ,
        'MM' => 'Multiple myeloma' ,
        'MPD' => 'Myeloproliferative disorder' ,
        'N' => 'Nonsense' ,
        'NHL' => 'Non-Hodgkin lymphoma' ,
        'NK/T' => 'Natural killer T cell' ,
        'NSCLC' => 'Non small cell lung cancer' ,
        'O' => 'Other' ,
        'PMBL' => 'Primary mediastinal B-cell lymphoma' ,
        'pre-B' => 'All Pre-B-cell acute lymphoblastic leukaemia' ,
        'Rec' => 'Recesive' ,
        'S' => 'Splice site' ,
        'T' => 'Translocation' ,
        'T-ALL' => 'T-cell acute lymphoblastic leukemia' ,
        'T-CLL' => 'T-cell chronic lymphocytic leukaemia' ,
        'TGCT' => 'Testicular germ cell tumour' ,
        'T-PLL' => 'T cell prolymphocytic leukaemia' ,
      }.freeze

      ROLE ={
        ONCOGENE: 'hyperactivity of the gene drives the transformation' ,
        TSG:      'loss of gene function drives the transformation. Some genes can play either of these roles depending on cancer type.' ,
        FUSION:   'the gene is known to be involved in oncogenic fusions.' ,
      }.freeze

      def self.identifier(linecnt)
        @row.gene_name
      end

      def self.gene_name
        # genename_relation(@row.gene_name)
        return nil
      end

      def self.entrez_id
        entrez_id_relation(@row.entrez_id)
      end

      def self.hallmark
        return "  #{@predicate}hallmark <#{CosmicRdf::URIs[:cosmiccensus]}#{@row.gene_name}>;\n" if 
          @row.hallmark != nil && @row.hallmark.downcase == 'yes'
        return nil
      end
      
      def self.tissue
        return rdf_elm("tissue", @row.tissue)
      end

      def self.molecular_genetics
        return rdf_elm("molecular_genetics", @row.molecular_genetics)
        return nil if @row.molecular_genetics == nil
        rdf_elm = []
        rdf_elm << "  #{@predicate}molecular_genetics"
        @row.molecular_genetics.split(/\,|\//).each do |s|
          s.strip!
          rdf_elm << "  ["
          rdf_elm << "    #{@predicate}molecular_genetics_abbreviation \"#{s}\";"
          rdf_elm << "    #{@predicate}molecular_genetics \"#{ABBREVIATIONS[s]}\""
          rdf_elm << "  ],\n"
        end
        rdf_elm.pop
        rdf_elm << "    ];"
        return rdf_elm.join("\n")
      end
     
      def self.mutation_type
        return rdf_elm("mutation_type", @row.mutation_type)
        return nil if @row.mutation_type == nil
        rdf_elm = []
        rdf_elm << "  #{@predicate}mutation_type"
        @row.mutation_type.split(/\,|\//).each do |s|
          s.strip!
          rdf_elm << "  ["
          rdf_elm << "    #{@predicate}mutation_type_abbreviation \"#{s}\";"
          rdf_elm << "    #{@predicate}mutation_type \"#{ABBREVIATIONS[s]}\""
          rdf_elm << "  ],"
        end
        rdf_elm.pop
        rdf_elm << "    ];"
        return rdf_elm.join("\n")
      end

      def self.rdf_elm(name, value)
        return nil if value == nil
        rdf_elm = []
        rdf_elm << "  #{@predicate}#{name}"
        value.split(/\,|\//).each do |s|
          s.strip!
          rdf_elm << "    ["
          rdf_elm << "      #{@predicate}#{name}_abbreviation \"#{s}\";"
          rdf_elm << "      #{@predicate}#{name} \"#{ABBREVIATIONS[s]}\""
          rdf_elm << "    ],"
        end
        rdf_elm.pop
        rdf_elm << "    ];"
        return rdf_elm.join("\n")
      end
      
      def self.role
        return nil if @row.role == nil
        rdf_elm = []
        rdf_elm << "  #{@predicate}role_in_cancer"
        @row.role.split(/\,|\//).each do |s|
          s.strip!
          rdf_elm << "    ["
          rdf_elm << "    #{@predicate}role_abbreviation \"#{s}\"; "
          rdf_elm << "    #{@predicate}role \"#{ROLE[s.upcase.to_sym]}\" "
          rdf_elm << "    ],"
        end
        rdf_elm.pop
        rdf_elm << "    ];"
        return rdf_elm.join("\n")
      end

      def self.other_germline
        if @row.other_germline == nil || @row.other_germline == ""
          return "  #{@predicate}other_germline: false ;" 
        elsif @row.other_germline.downcase == 'yes'
          return "  #{@predicate}other_germline: true ;" 
        else
          return nil
        end
      end

      def self.use_prefix
        prefix =[
          CosmicRdf::PREFIX[:cosmicgene],
          CosmicRdf::PREFIX[:ncbigene],
          CosmicRdf::PREFIX[:cosmiccensus],
        ]
      end

      def self.rdf_catalog
        header = <<'          END'
          mutation:
              a dcat:Dataset ;
              dct:title COSMIC MUTATION CENSUS ;
              rdfs:label cosmic census ;
              dcat:keyword "cancer","census", "tier" ;
              dcat:distribution "cancer_gene_census.csv" ;
              dcterms:language lang:en ;
              .
          END
      end
      
    end #- end Class
  end #- end Converter
end #- end CosmicRdf
