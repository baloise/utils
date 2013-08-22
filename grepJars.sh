#!/bin/bash

#
# Recursively finds all archive files (default: "*-sources.jar") in a given path and
# searches their contents for a specified token.
#
# Outputs a list of matching filenames.
#
# Author: rahel.luethy@baloise.com
#

# Display usage if less than two arguments supplied
if [ $# -le 1 ] 
then 
	echo "Usage: grepJars [search-path] [search-token]" 
	exit 1
fi

# Read path & token from argument list
SEARCH_PATH=$1
SEARCH_TOKEN=$2

# Filenames to search for (matching files must be 'unzippable')
FILE_NAME_PATTERN="*-sources.jar"

for i in `find $SEARCH_PATH -name $FILE_NAME_PATTERN`
do
  # Extract file to stream and search for token
  unzip -p $i | grep $SEARCH_TOKEN > /dev/null
  if [ $? == 0 ]
  then
    echo "$i"
  fi
done