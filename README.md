# bbb-stats (BigBlueButton simple dashboard)

![image](https://user-images.githubusercontent.com/1224883/82800772-84d66d80-9e7c-11ea-9d64-319d640a465f.png)

Very basic html dashboard to display currently running BigBlueButton meetings and connected users on your bbb server.  
  
Requires: access to bigbluebutton getMeetings API, curl and xsltproc
  

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

Add the script to cron (eg. every minute)
```
# m h  dom mon dow   command
* * * * * /usr/local/bin/bbb_getMeetings2html.sh 
```
 
Browse your BigBlueButton dashboard:
```
https://bigbluebutton.example.com/stats
```
