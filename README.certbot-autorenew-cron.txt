#########################################################################
# James Hipp
# System Support Engineer
# Ready Computing
#
# Bash script to automate CertBot SSL Cert Renewal
# Schedule this to run in Cron once Monthly
#
# One script specifically for RHEL/CentOS and HTTPD
# One script specifically for Ubuntu and Apache2
#
# Usage = certbot_autorenew_cron.RHEL.sh
# Ex: ./certbot_autorenew_cron.RHEL.sh
#
# # Usage = certbot_autorenew_cron.Ubuntu.sh
# Ex: ./certbot_autorenew_cron.Ubuntu.sh
#
# CronJob Should Look Similar to This:
# 0 20 1 * * /etc/scripts/certbot_autorenew_cron.RHEL.sh
#
# Should Run First of Every Month at 8 PM
#
#
### CHANGE LOG ###
#
#
#########################################################################


----------


Reasoning for Script:

We use LetsEncrypt and CertBot for all our of SSL certificates, and with that
comes only a 90-day validity period. There was a need to update these in an
automated fashion, as it come up quite frequently. The best timeframe to do 
this with a cronjob seems to be monthly. If you update too frequently, then
LetsEncrypt will flag that and not renew it.


----------


Logical Steps:

- Ensure we have a log file in appropriate /var/log directory
- Stop httpd or apache2
- Certbot renew
- Start httpd or apache2
- Update log accordingly throughout


----------


Test Usage:

(*** Going to run manually, but usually this would be in a CronJob ***)

[root@ca-demo-001 ~]# openssl x509 -in /etc/letsencrypt/live/ca.readycomputing.com/cert.pem -text -noout |egrep "Before|After"
            Not Before: Apr 26 22:57:18 2019 GMT
            Not After : Jul 25 22:57:18 2019 GMT

[root@ca-demo-001 ~]# crontab -l
0 20 1 * * /root/scripts/certbot-autorenew-cron/certbot_autorenew_cron.RHEL.sh

[root@ca-demo-001 ~]# /root/scripts/certbot-autorenew-cron/certbot_autorenew_cron.RHEL.sh 
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Cert is due for renewal, auto-renewing...
Plugins selected: Authenticator standalone, Installer None
Starting new HTTPS connection (1): acme-v02.api.letsencrypt.org
Renewing an existing certificate
Performing the following challenges:
http-01 challenge for ca.readycomputing.com
Waiting for verification...
Cleaning up challenges

[root@ca-demo-001 ~]# openssl x509 -in /etc/letsencrypt/live/ca.readycomputing.com/cert.pem -text -noout |egrep "Before|After"
            Not Before: Jul  8 12:32:18 2019 GMT
            Not After : Oct  6 12:32:18 2019 GMT

[root@ca-demo-001 ~]# cat /var/log/httpd/certbot_autorenew_cron.log 
CertBot Auto-Renewal Script Running
Timestamp = Mon Jul  8 09:32:13 EDT 2019
------
Stopping Apache HTTPD Service
Running CertBot Renew
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/ca.readycomputing.com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
new certificate deployed without reload, fullchain is
/etc/letsencrypt/live/ca.readycomputing.com/fullchain.pem
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations, all renewals succeeded. The following certs have been renewed:
  /etc/letsencrypt/live/ca.readycomputing.com/fullchain.pem (success)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Starting Apache HTTPD Service



