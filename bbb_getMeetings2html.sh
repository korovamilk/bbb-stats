#!/bin/bash
# BigBlueButton getMeetings2html
# outputs a readable html from bbb meetings xml API
# add to crontab and execute every minute or so
# DO NOT place this script under /var/www (exposes API)
#
# v.20200525 Marco Agate ~ https://github.com/korovamilk/bbb-stats

# get your API endpoint by using: 
#     bbb-conf --secret
# navigate to the API-MATE link 
#   eg.  Link to the API-Mate:
#        https://mconf.github.io/api-mate/#server=https://bigbluebutton.example.com/bigbluebutton/&sharedSecret=XYZ
# copy and then enter here the "getMeetings" URL, eg:
API_ENDPOINT="https://bigbluebutton.example.com/bigbluebutton/api/getMeetings?checksum=XYZ"

STYLE="/var/www/bigbluebutton/stats/style.xsl"
INPUT="/tmp/bbb_stats_input.xml"
OUTPUT="/var/www/bigbluebutton/stats/index.html"
NOMEETINGS="/var/www/bigbluebutton/stats/nomeetings.html"

curl -sS ${API_ENDPOINT} | awk '{if(NR>2)print}' | sed '$d'  > ${INPUT}
if [ $(grep "noMeetings" ${INPUT}) ] ; then  
     cp -f ${NOMEETINGS} ${OUTPUT}
else xsltproc -o ${OUTPUT} ${STYLE} ${INPUT}
fi
rm $INPUT
exit 0
