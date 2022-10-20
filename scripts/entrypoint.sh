service cron start

sed -i s/ENVMAIL/$MAIL/ scripts/cronjob
sed -i s/ENVPASS/$MAILPASS/ scripts/cronjob
sed -i s/ENVHOST/$HOST/ scripts/cronjob
sed -i s/ENVPORT/$PORT/ scripts/cronjob


cp scripts/cronjob /etc/cron.d/

if [ ! -f "/log/mailcli.log" ]; then
	touch /log/mailcli.log
fi

# aggiorna la stampa in tempo reale
tail +1f /log/mailcli.log
