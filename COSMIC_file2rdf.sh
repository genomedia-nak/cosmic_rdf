#/bin/sh -env bash

set -eu

FILE_DIR='/opt'

cwd=`dirname "${0}"`
# FILE_DIR = COSMIC file directory
# ruby ${cwd}/bin/file2rdf.rb -d ${FILE_DIR}
ruby ${cwd}/bin/file2rdf.rb

