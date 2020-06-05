#cp licenseKey.txt tools/oxygen-publishing-engine-3.x/licensekey.txt

rm -rf output

REPONAME=`basename $PWD`
PARENTDIR=`dirname $PWD`
USERNAME=`basename $PARENTDIR`

# Writes the license key in a file
# Assumes that $LICENSE_KEY contains the license key with all /n's replaced by @@
printf "%s" "$LICENSE_KEY" > tools/oxygen-publishing-engine-3.x/licensekey.txt
sed -i 's/@@/\n/g' tools/oxygen-publishing-engine-3.x/licensekey.txt


# Send some parameters to the "editlink" plugin as system properties
export ANT_OPTS="$ANT_OPTS"

tools/oxygen-publishing-engine-3.x/bin/dita -i $DITAMAP -f webhelp-responsive -o $OUT_DIR -t $TEMP_DIR -Dwebhelp.publishing.template.descriptor=$OPT_FILE -Dwebhelp.publishing.template=$OPT_DIR