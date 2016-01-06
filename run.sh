#!/bin/bash

LATEST_TITLEIZE_VERSION=1.0.0
hash ruby 2>/dev/null || { echo "Ruby is required, but not installed. Aborting..." >&2; exit 1; }

ruby_version=`ruby -v`
echo "Found $ruby_version"

# set correct gems argument for no documentation
if [[ "$ruby_version" =~ "ruby 1" ]]; then
    no_doc="--no-rdoc --no-ri"
else
    no_doc="-N"
fi

gem install titleize $no_doc
gem install optparse $no_doc

ruby ./title-checker.rb $WERCKER_TITLEIZER_CHECK_BASEDIR $WERCKER_TITLEIZER_CHECK_VERBOSE
