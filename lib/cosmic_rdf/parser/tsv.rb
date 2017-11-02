# coding: utf-8

require 'zlib'
require 'csv'
require 'active_support'
require 'active_support/core_ext'

require 'cosmic_rdf/parser/row'

module CosmicRdf
  module Parser
    # Tsv file parser
    class Tsv
      HEADERS = {}.freeze

      def initialize(gzipped_tsv_file)
        raise ArgumentError, "File not found: #{gzipped_tsv_file}" unless
          File.exist? gzipped_tsv_file
        basename = File.basename(gzipped_tsv_file)
        raise ArgumentError, "Invalid filename: #{basename}" unless
          FILES[self.class.name.split('::').last.underscore.to_sym] == basename

        @io = Zlib::GzipReader.open(gzipped_tsv_file)
        @tsv = CSV.new(@io, col_sep: "\t", headers: :first_row)
      end

      def self.open(tsv_file)
        obj = new(tsv_file)
        if block_given?
          begin
            yield obj
          ensure
            obj.close
          end
        else
          obj
        end
      end

      def each
        @tsv.each do |row|
          yield Row.new(row, self.class::HEADERS)
        end
      end

      def close
        @io.close
      end
    end
  end
end
