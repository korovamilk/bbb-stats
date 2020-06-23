# bbb-stats (BigBlueButton simple dashboard)

![image](https://user-images.githubusercontent.com/1224883/85375220-45ac4280-b536-11ea-8dc0-2ad319976190.png)

Very basic html dashboard to display currently running BigBlueButton meetings and connected users on your bbb server.  
It also provides a link to kill the conference rooms (to avoid accidental room killings, you have to copy the link and paste in browser)
  
Requires: access to BigBlueButton Secret and API, curl, xsltproc and apache2-utils (for HTTP basic auth password)
```
apt-get install curl xsltproc apache2-utils
```

Customize the  bbb_getMeetings2html.sh  shell script with your shared secret and API endpoint:

```
bbb-conf --secret

    URL: https://bigbluebutton.example.com/bigbluebutton/
    Secret: XXXXYYYYZZZZ

    Link to the API-Mate:
    https://mconf.github.io/api-mate/#server=https://bigbluebutton.example.com/bigbluebutton/&sharedSecret=XXXXYYYYZZZZ
```

Copy the "Secret" and paste in the script, eg:  
``` 
sharedSecret="XXXXYYYYZZZZ"
```

Navigate to the API-MATE link above and copy the "getMeetings" URL. Paste it in the script, eg:
```
API_ENDPOINT="https://bigbluebutton.example.com/bigbluebutton/api/getMeetings?checksum=ZZZYYYXXX"
```
  
Copy the  bbb_getMeetings2html.sh  shell script under your path (eg. /usr/local/bin) and the stats folder under your BigBlueButton server nginx path ( /var/www/bigbluebutton/stats )  

Add the script to cron (eg. launch every 15 seconds)
```
# m h  dom mon dow   command
* * * * * /usr/local/bin/bbb_getMeetings2html.sh 
* * * * * sleep 15 ; /usr/local/bin/bbb_getMeetings2html.sh
* * * * * sleep 30 ; /usr/local/bin/bbb_getMeetings2html.sh
* * * * * sleep 45 ; /usr/local/bin/bbb_getMeetings2html.sh
```

Create HTTP basic auth password to protect access to stats page:
```
htpasswd -c /etc/nginx/.htpasswd bbb-status-user
```

Add the location directive for /stats to your Nginx web server  (/etc/nginx/sites-available/bigbluebutton)

```
location /stats {
    auth_basic "BBB Stats - Passwortabfrage";
    auth_basic_user_file /etc/nginx/.htpasswd;
         
    root   /var/www/bigbluebutton;
    index  index.html;
}
```

Check your Nginx configuration and then reload the service:
```
nginx -t 
systemctl reload nginx
```

Browse your BigBlueButton dashboard and login with user "bbb-status-user" and the password you chose:
```
https://bigbluebutton.example.com/stats
```  
