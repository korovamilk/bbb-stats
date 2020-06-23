#!/bin/bash
# BigBlueButton getMeetings2html
# outputs a readable html from bbb meetings xml API
# add to crontab and execute every minute or so
# DO NOT place this script under /var/www/bigbluebutton (exposes API)
#
# v.20200525 Marco Agate ~ https://github.com/korovamilk/bbb-stats

# get your shared secret and API endpoint by using: 
#     bbb-conf --secret
# note down your shared sexcret:
sharedSecret="XXXXYYYYZZZZ"
# navigate to the API-MATE link 
#   eg.  Link to the API-Mate:
#        https://mconf.github.io/api-mate/#server=https://bigbluebutton.example.com/bigbluebutton/&sharedSecret=XYZ
# copy and then enter here the "getMeetings" URL, eg:
API_ENDPOINT="https://bigbluebutton.example.com/bigbluebutton/api/getMeetings?checksum=ZZZYYYXXX"
# enter your BigBlueButton fully qualified domain name, eg: 
myBBB="bigbluebutton.example.com"

STYLE="/var/www/bigbluebutton/stats/style.xsl"
INPUT="/tmp/bbb_stats_input.xml"
OUTPUT="/var/www/bigbluebutton/stats/index.html"
# show a nice message when no meeting is running
NOMEETINGS="/var/www/bigbluebutton/stats/nomeetings.html"

curl -sS ${API_ENDPOINT} | awk '{if(NR>2)print}' | sed '$d'  > ${INPUT}
if [ $(grep "noMeetings" ${INPUT}) ] || [ ! -s ${INPUT} ] ; then  
     cp -f ${NOMEETINGS} ${OUTPUT}
else xsltproc -o ${OUTPUT} ${STYLE} ${INPUT}
    # placeholder for kill meeting link
    for CHANGEME in $(grep -Eo "___.*___" ${OUTPUT})
    do LINE=$(echo ${CHANGEME} | sed "s/___//g")
       meetingID=$(echo ${LINE} | cut -d\; -f1)
       password=$(echo ${LINE}  | cut -d\; -f2)
       myString=$(echo endmeetingID=${meetingID}\&password=${password}${sharedSecret})
       myChecksum=$(echo -n $myString | sha1sum | cut -d" " -f1)
       myURL=$(echo -n https://${myBBB}/bigbluebutton/api/end?meetingID=${meetingID}\\\&password=${password}\\\&checksum=${myChecksum})
       sed -i "s#$CHANGEME#$myURL#g" ${OUTPUT}
    done
fi
rm -f $INPUT
exit 0
