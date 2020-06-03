# bbb-stats (BigBlueButton simple dashboard)

![image](https://user-images.githubusercontent.com/1224883/83612346-94436e00-a582-11ea-90af-35bd099c70ac.png)

Very basic html dashboard to display currently running BigBlueButton meetings and connected users on your bbb server.  
  
Requires: access to bigbluebutton getMeetings API, curl, xsltproc and apache2-utils (for HTTP basic auth password)
```
apt-get install curl xsltproc apache2-utils
```

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
