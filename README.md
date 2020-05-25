# bbb-stats
BigBlueButton simple stats dashboard  

Very basic html dashboard to display all currently running BigBlueButton meetings.  
  
Requires: curl and xsltproc  

Customize the  bbb_getMeetings2html.sh  shell script with your API endpoint:

```
bbb-conf --secret
```
Navigate to the API-MATE link:   
```
https://mconf.github.io/api-mate/#server=https://bigbluebutton.example.com/bigbluebutton/&sharedSecret=XYZ
```

Copy the "getMeetings" URL from API-MATE, and paste in the script eg:
```
API_ENDPOINT="https://bigbluebutton.example.com/bigbluebutton/api/getMeetings?checksum=XYZ"
```
  
Copy the  bbb_getMeetings2html.sh  shell script under your path (eg. /usr/local/bin) and the stats folder under your BigBlueButton server nginx path ( /var/www/bigbluebutton/stats )  

Add the script to cron (every minute)
```
# m h  dom mon dow   command
* * * * * /usr/local/bin/bbb_getMeetings2html.sh 
```

Browse your BigBlueButton dashboard:
```
https://bigbluebutton.example.com/stats
```