# parte il demone di cron
service cron start

# tramite il comando sed sostituisco al cronjob i valori delle variabili d'ambiente
sed -i s/ENVMAIL/$MAIL/ scripts/cronjob
sed -i s/ENVPASS/$MAILPASS/ scripts/cronjob
sed -i s/ENVHOST/$HOST/ scripts/cronjob
sed -i s/ENVPORT/$PORT/ scripts/cronjob
sed -i s/ENVMIN/$MIN/ scripts/cronjob
sed -i s/ENVHOUR/$HOUR/ scripts/cronjob
sed -i s/ENVMDAY/$MDAY/ scripts/cronjob
sed -i s/ENVMONTH/$MONTH/ scripts/cronjob
sed -i s/ENVWDAY/$WDAY/ scripts/cronjob

# copio il cronjob nella cartella di default di cron
cp scripts/cronjob /etc/cron.d/

# se non esiste il file di log, viene creato
if [ ! -f "/log/mailcli.log" ]; then
	touch /log/mailcli.log
fi

# aggiorna la stampa in tempo reale
tail +1f /log/mailcli.log
