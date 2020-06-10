#cp licenseKey.txt tools/oxygen-publishing-engine-3.x/licensekey.txt

rm -rf output

echo "Download Oxygen Publishing Engine"
wget https://mirror.oxygenxml.com/InstData/PublishingEngine/oxygen-publishing-engine-3.x.zip
unzip oxygen-publishing-engine-3.x.zip
chmod +x oxygen-publishing-engine-3.x/bin/dita

echo "Inject license"

# Copy the license key in OPE
cp licenseKey.txt oxygen-publishing-engine-3.x/licensekey.txt

echo "Generate WebHelp Responsive Output from " ${DITAMAP}

oxygen-publishing-engine-3.x/bin/dita -i $DITAMAP -f webhelp-responsive -filter=$DITAVAL -o $OUT_DIR -t $TEMP_DIR -Dwebhelp.publishing.template.descriptor=$OPT_FILE -Dwebhelp.publishing.template=$OPT_DIR