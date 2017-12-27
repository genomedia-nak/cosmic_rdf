#! /bin/sh

# exec ruby -S -x "$0" "$@"
#! ruby

$: << File.expand_path('../lib' , __dir__)
require 'fileutils'
require 'pathname'
require "cosmic_rdf"
require 'optparse'



def localmain()
  FileUtils.mkdir_p(@out_dir) unless FileTest.exist?(@out_dir)
  CosmicRdf::FILES.each do |symbl, file|
    rdf_create(symbl)
  end
end

def rdf_create(symbl)
  puts "#{symbl} in progress"
  classify = symbl.capitalize
  cosmic_file = @dest_dir.join(CosmicRdf::FILES[symbl])
  rdf_file  =  @out_dir.join(CosmicRdf::RDFS[symbl])
  parser = CosmicRdf::Parser.const_get(classify)
  converter = CosmicRdf::Converter.const_get(classify)
  parser.open(cosmic_file) do |tsv|
    converter.rdf_write(rdf_file, tsv)
  end
end


def _test_rdf_create_sample
  cnt = 0
  gz_file = @dest_dir.join(CosmicRdf::FILES[:sample])
  rdf_file  =  @out_dir.join(CosmicRdf::RDFS[:sample])
  CosmicRdf::Parser::Sample.open(gz_file) do |tsv|
    _s = CosmicRdf::Converter::Sample.rdf_write(rdf_file, tsv)
  end
end



puts "start script..."
option={d: '/opt'}
OptionParser.new do |opt|
  opt.on('-d dir-path',   'default: /opt')   {|v| option[:d] = v}
  opt.parse!(ARGV)
end

# downloaded files directory
@dest_dir = Pathname(option[:d])
@out_dir  = @dest_dir.join('rdf')
puts "COSMIC downloaded-file directory : #{@dest_dir}"
puts "COSMIC parsed-rdf-file directory : #{@out_dir}"
res = localmain()
puts "end script..."