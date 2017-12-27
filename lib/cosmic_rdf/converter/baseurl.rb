# coding: utf-8

module CosmicRdf
  module Converter
    class Baseurl
      def initialize()
        # puts "### #{self.class} ###"
      end
      
      # read gzip-file-obj
      def self.rdf_write(rdf_file, tsv)

        @current = self.name.split('::').last.underscore.to_sym
        @predicate = CosmicRdf::PREDICATE_PREFIX[@current.to_sym].split(" ")[1].split(":")[0] + ":"
        
        linecnt = 0
        File.open(rdf_file,"w") do |f|
          f.puts define_header()
          f.puts use_prefix()
          f.puts CosmicRdf::PREDICATE_PREFIX[@current.to_sym]
          f.puts ""
          tsv.each do |obj|
            linecnt += 1
            f.puts rdf_turtle(linecnt, obj)
          end
        end
      end

      def self.rdf_turtle(linecnt, obj)
        @row = obj
        row_ident = identifier(linecnt)
        rdf_ttl = []
        rdf_ttl << "<#{CosmicRdf::URIs[@current.to_sym]}#{row_ident}>"
        @row.attributes.each do |name, val|
          next if @ignore.include?(name.to_sym) ||
                  @add_info.include?(name.to_sym) || 
                  val.to_s.empty? 

          unless val.is_a? Integer
            rdf_ttl <<  "  #{@predicate}#{name} \"#{val}\" ;"
          else
            rdf_ttl <<  "  #{@predicate}#{name} #{val} ;"
          end
        end
        
        ## ignore
        @ignore.each do |name|
          rdf_ttl <<  "  #{@predicate}#{name} \"#{self.send(name)}\" ;\n" unless name == nil
        end
        
        ## add_info
        @add_info.each do |name|
          rdf_turtle = self.send(name)
          rdf_ttl << rdf_turtle unless rdf_turtle == nil
        end

        # record-end
        rdf_ttl << "."
        return rdf_ttl
      end

      def self.genename_relation(cosm_gene)
        if cosm_gene.to_s =~ /^[A-Z0-9]+$/
          return "  #{@predicate}gene_name[\n" +
                 "     a #{@predicate}Gene;\n" +
                 "     #{@predicate}gene_name \"#{cosm_gene}\";\n" +
                 "     #{@predicate}cosmicurl <#{CosmicRdf::URIs[:cosmicgene]}#{cosm_gene}>\n"+
                 "  ];"
        end
        unless cosm_gene == nil
          return "  #{@predicate}gene_name [\n" +
                 "     a #{@predicate}Gene;\n" +
                 "     #{@predicate}gene_name \"#{cosm_gene}\";\n" +
                 "     #{@predicate}cosmicurl <#{CosmicRdf::URIs[:genedirect]}#{cosm_gene}>\n"+
                 "  ];"
        end
        return nil
      end

      def self.genesymbol_relation(acc)
        return nil if acc == "Unclassified_Cell_type_specific"
        if acc =~ /^((AC|AP|NC|NG|NM|NP|NR|NT|NW|XM|XP|XR|YP|ZP)_\d+|(NZ\_[A-Z]{4}\d+))(\.\d+)?$/
          return  "  #{@predicate}accession[\n" +
                  "    a #{@predicate}Gene;\n" +
                  "    #{@predicate}accession_number \"#{acc}\";\n" +
                  "    #{@predicate}ncbi <#{CosmicRdf::URIs[:refseq]}#{acc}>\n" +
                  "  ];"
        end
        if acc =~ /^((ENS[A-Z]*[FPTG]\d{11}(\.\d+)?)|(FB\w{2}\d{7})|(Y[A-Z]{2}\d{3}[a-zA-Z](\-[A-Z])?)|([A-Z_a-z0-9]+(\.)?(t)?(\d+)?([a-z])?))$/
          return  "  #{@predicate}accession [\n" +
                  "    a #{@predicate}Gene;\n" +
                  "    #{@predicate}accession_number \"#{acc}\";\n" +
                  "    #{@predicate}ensembl <#{CosmicRdf::URIs[:ensembl]}#{acc}>\n" +
                  "  ];"
        end
        return    "  #{@predicate}accession_number \"#{acc}\"" unless acc == nil
        return nil
      end

      def self.hgnc_relation(hgnc_id)
        if hgnc_id.to_s =~ /^[0-9]+$/
          return  "  #{@predicate}hgnc [\n" +
                  "    a #{@predicate}Gene;\n" +
                  "    #{@predicate}hgnc_id \"#{hgnc_id}\";\n" +
                  "    #{@predicate}hgnc <#{CosmicRdf::URIs[:hgncurl]}#{hgnc_id}>\n" +
                  "  ];"
        end
        return    "  #{@predicate}hgnc: #{hgnc_id} ;" unless hgnc_id == nil
        return nil
      end
      
      def self.sampleid_relation(sample_id)
        if sample_id.to_s =~ /^[0-9]+$/
          return  "  #{@predicate}sample [\n" +
                  "    #{@predicate}sample_id #{sample_id};\n" +
                  "    rdfs:seeAlso <#{CosmicRdf::URIs[:sample]}#{sample_id}>\n" +
                  "  ];"
        end
        return    "  #{@predicate}sample \"#{sample_id}\" ;" unless sample_id == nil
        return nil
      end

      def self.mutationid_relation(mut_id)
        #if mut_id =~ /^COSM[0-9]+$/
        #  mut_id_no = mut_id.delete("COSM")
        #  return  "  #{@predicate}mutation[\n" +
        #          "    #{@predicate}mutation_id \"#{mut_id}\";\n" +
        #          "    rdfs:seeAlso <#{CosmicRdf::URIs[:mutationid]}#{mut_id_no}>\n" +
        #          "  ];"
        #end
        return nil if mut_id == nil || mut_id == ""
        return    "  :mutation #{mut_id} ;" if mut_id.is_a? Integer
         mut_id.delete!("COSM") 
        if mut_id =~ /^[0-9]+$/
          return    "  :mutation #{mut_id} ;"
        end

      end
      
      def self.cosmicgeneid_relation(cosm_gene_id)
        if cosm_gene_id.to_s =~ /^[0-9]+$/
          return "  #{@predicate}cosmic_geneid \"COSG#{cosm_gene_id}\" ;\n"
        elsif cosm_gene_id != nil
          return "  #{@predicate}cosmic_geneid \"#{cosm_gene_id}\" ;\n"
        end
        return nil
      end

      def self.pmid_relation(pmid)
        if pmid.to_s =~ /^[0-9]+$/
          return  "  #{@predicate}pubmed [\n" +
                  "    a #{@predicate}Pubmed;\n" +
                  "    #{@predicate}pmid \"#{pmid}\";\n" +
                  "    #{@predicate}pubmed <#{CosmicRdf::URIs[:pubmed]}#{pmid}>\n" +
                  "  ];"
        end
        return nil
      end
      
      def self.studyid_relation(study_id)
        if study_id.to_s =~ /^[0-9]+$/
          return  "  #{@predicate}study [\n" +
                  "    #{@predicate}study_id \"#{study_id}\";\n" +
                  "    rdfs:seeAlso <#{CosmicRdf::URIs[:study]}#{study_id}>\n" +
                  "  ];"
        end
        return "  #{@predicate}study_id \"#{study_id}\" ;" unless study_id == nil
        return nil
      end

      def self.tcga_sample_relation(sample_name)
        if sample_name.start_with?("TCGA")
          return  "  #{@predicate}sample [\n" +
                  "    #{@predicate}sample_name \"#{sample_name}\";\n" +
                  "    #{@predicate}cancerDigital <#{CosmicRdf::URIs[:cancerDigital]}#{sample_name}>\n" +
                  "  ];"
        end
        return "  #{@predicate}sample_name \"#{sample_name}\" ;" unless sample_name == nil
        return nil
      end

      def self.cosmicgene_relation(cosm_gene)
        return "  #{@predicate}cosmicgene: #{cosm_gene} ;" if cosm_gene =~ /^[0-9]+$/
        return nil
      end

      def self.define_header
        header = <<'EOS'
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix up: <http://identifiers.org/uniprot/> .
@prefix dcterms: <http://purl.org/dc/terms/> .
EOS
      end

    end #- end Class
  end #- end Parser
end #- end CosmicRdf


