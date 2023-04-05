#!/bin/bash

SIMPLEAUTH_SESS=$(printenv SIMPLEAUTH_SESS)
CRON_STRING=$(printenv CRON_STRING)

if [ -z "$SIMPLEAUTH_SESS" ]; then
    echo "SIMPLEAUTH_SESS Environment variable is required"
    exit
fi

HBD_COMMAND="hbd -s '$SIMPLEAUTH_SESS' --library-path '/home/hbd/'"
TROVE_COMMAND="trove_downloader run -k '$SIMPLEAUTH_SESS' -p 'all' -l '/home/trove' -f Reverse"

if [ -z "$CRON_STRING" ]; then
    echo "Using default cron string. None was manually entered."
    CRON_STRING="@reboot"
fi

touch /var/log/cron.log

(echo "$CRON_STRING $HBD_COMMAND >> /var/log/cron.log" && echo "$CRON_STRING $TROVE_COMMAND >> /var/log/cron.log") | crontab
printf "Current cron file:\n"
crontab -l
cron && tail -F /var/log/cron.log