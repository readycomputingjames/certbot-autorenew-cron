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





