#!/bin/bash
#########################################################################
# James Hipp
# System Support Engineer
# Ready Computing
#
# Bash script to automate CertBot SSL Cert Renewal
# Schedule this to run in Cron once Monthly
#
# This specific script is for Ubuntu and Apache2
#
# Usage = certbot_autorenew_cron.Ubuntu.sh
# Ex: ./certbot_autorenew_cron.Ubuntu.sh
#
# CronJob Should Look Similar to This:
# 0 20 1 * * /etc/zabbix/scripts/certbot_autorenew_cron.Ubuntu.sh
#
# Should Run First of Every Month at 8 PM
#
#
### CHANGE LOG ###
#
#
#########################################################################

LOGFILE="/var/log/apache2/certbot_autorenew_cron.log"

create_log () {

   ### Setup Human-Readable Log File ###

   echo "" >> $LOGFILE
   echo "CertBot Auto-Renewal Script Running" >> $LOGFILE
   echo "Timestamp = `date`" >> $LOGFILE
   echo "" >> $LOGFILE
   echo "------" >> $LOGFILE
   echo "" >> $LOGFILE

}

stop_apache () {

   echo "Stopping Apache Service" >> $LOGFILE
   echo "" >> $LOGFILE
   service apache2 stop >> $LOGFILE
   echo "" >> $LOGFILE

}

certbot_renew () {

   echo "Running CertBot Renew" >> $LOGFILE
   echo "" >> $LOGFILE
   certbot renew >> $LOGFILE
   echo "" >> $LOGFILE

}

start_apache () {

   echo "Starting Apache Service" >> $LOGFILE
   echo "" >> $LOGFILE
   service apache2 start >> $LOGFILE
   echo "" >> $LOGFILE

}

main () {

   create_log
   stop_apache
   certbot_renew
   start_apache

}

main









