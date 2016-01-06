if [ -z "$WERCKER_TITLEIZER_TEST_BASEDIR" ]; then
	WERCKER_TITLEIZER_TEST_BASEDIR="-b ${WERCKER_SOURCE_DIR}"
fi

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

$WERCKER_STEP_ROOT ./title-checker.rb $WERCKER_TITLEIZER_TEST_BASEDIR $WERCKER_TITLEIZER_TEST_VERBOSE
