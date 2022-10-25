# Publicity bot mst

A causa dell'aumento della complessità di gestione di specifici problemi, workshop e conferenze, dei tool automatici ci vengono in soccorso. Questo progetto mira a inviare mail, con una specifica routine, tramite Google con un semplice programma a riga di comando.

# How to build it
Questa applicazione è nata a partire da ciò che è stato pubblicato dal Professore Carnevale all'interno del suo personale repository: lcarnevale/publicity-bot.
Basandomi su quanto è stato condiviso ho adattato il tutto per essere distribuibile tramite container.

Il progetto si basa sull'utilizzo del servizio SMTP di Gmail per inviare mail, tramite la porta 465. Per permetterne l'utilizzo da CLI è necessario abilitare l'autentificazione a 2 fattori e generare una Password per le App per effettuare il login, in quanto dal 30 maggio 2022 Google non supporterà più l'uso di app di terze parti o dispositivi che chiedono di accedere all'Account Google utilizzando solo il nome utente e la password.

L'applicazione richiede la lista dei destinatari, il corpo e l'oggetto della mail. La lista dei destinatari in copia è, invece, opzionale.
Ognuno di questi file devono essere salvati in file indipendeti come segue.

<p align="center">
  <img src="docs/emails-to-sample.png">
  <br>
  <em>Esempio di mail to</em>
  <br> <br>
  <img src="docs/emails-cc-sample.PNG">
  <br>
  <em>Esempio di mail cc</em>
  <br> <br>
  <img src="docs/emails-body-sample.png">
  <br>
  <em>Esempio del corpo della mail</em>
</p>

### Cron
Per mandare mail seguendo una routine utilizziamo il demone di pianificazione dei lavori basato sul tempo, <b>Cron</b>. Cron viene eseguito in background e le operazioni pianificate, denominate "processi cron", vengono eseguite automaticamente.
I Cron job vengono registrati e gestiti in un file noto come crontab. Ciascun profilo utente sul sistema può avere il proprio crontab in cui programmare i lavori, che è archiviato in /var/spool/cron/crontabs/.

Per pianificare un job si deve aprire il crontab e aggiungere un'attività scritta sotto forma di un'espressione cron. La sintassi per le espressioni cron può essere suddivisa in due elementi: la pianificazione e il comando da eseguire.

Il comando può essere praticamente qualsiasi comando che eseguiresti normalmente sulla riga di comando. La componente di pianificazione della sintassi è suddivisa in 5 diversi campi, che vengono scritti nel seguente ordine:

|     Field        | Allowed Values  |
|:-----------------|:---------------:|
| Minute           | 0-59            |
| Hour             | 0-23            |
| Day of the month | 1-31            |
| Month            | 1-12 or JAN-DEC |
| Day of the week  | 0-6 or SUN-SAT  |

Nelle espressioni cron, un asterisco è una variabile che rappresenta tutti i valori possibili. Pertanto, un'attività pianificata con * * * * * ... verrà eseguita ogni minuto di ogni ora di ogni giorno di ogni mese.


Il Cronjob pianificato per questo progetto è il seguente:
```bash
MAILPASS=ENVPASS
MAIL=ENVMAIL
PORT=ENVPORT
HOST=ENVHOST

ENVMIN ENVHOUR ENVMDAY ENVMONTH ENVWDAY root /bin/bash -c <PATH/OF/start_bot.sh>
```
il cron necessita le specifiche variabili d'ambinete all'interno del cronjob stesso. In questa prova ho pianificato il job per eseguire ogni minuto il bot, configurando la pianificazione tramite variabili d'ambinete che vengono configurante dentro il docker-compose.yml e sostituite grazie all'entrypoint.sh.

### Script
Per rendere il tutto più automatico possibile sono stati pensati due script sh:
- il primo, chiamato start_bot, esegue il bot con i seguenti parametri
```bash
<PATH/OF/python3> <PATH/OF/main.py> \
    --host $HOST \
    --port $PORT \
    --from $MAIL \
    --to <PATH/OF/mailto.csv> \
    --cc <PATH/OF/cc.csv> \
    --subject <PATH/OF/subject.csv> \
    --body <PATH/OF/body.csv>
```

- il secondo, chiamato entrypoint, sarà il primo comando eseguito dal container. In ordine:
<ol>
	<li>avvio del demone di cron</li>
	<li>col comando sed sostisuisco al cronjob i valori delle variabili d'ambiente</li>
	<li>copio il cronjob nella cartella di default di cron</li>
	<li>l'if è pensato per controllare se esiste il file di log; se non esiste viene creato</li>
	<li>col comando tail +1f aggiorno la stampa del log in tempo reale</li>
</ol>

```bash
service cron start

sed -i s/ENVMAIL/$MAIL/ <PATH/OF/cronjob>
sed -i s/ENVPASS/$MAILPASS/ <PATH/OF/cronjob>
sed -i s/ENVHOST/$HOST/ <PATH/OF/cronjob>
sed -i s/ENVPORT/$PORT/ <PATH/OF/cronjob>
sed -i s/ENVMIN/$MIN/ <PATH/OF/cronjob>
sed -i s/ENVHOUR/$HOUR/ <PATH/OF/cronjob>
sed -i s/ENVMDAY/$MDAY/ <PATH/OF/cronjob>
sed -i s/ENVMONTH/$MONTH/ <PATH/OF/cronjob>
sed -i s/ENVWDAY/$WDAY/ <PATH/OF/cronjob>

cp <PATH/OF/cronjob> /etc/cron.d/

if [ ! -f "/log/mailcli.log" ]; then
        touch /log/mailcli.log
fi

tail +1f /log/mailcli.log
```

### Docker
Docker è


# How to use it
Dal punto di vista dell'utilizzatore è necessario, dapprima, registrarsi a Docker Hub, abilitare l'autentificazione a 2 fattori e infine generare un Access Token per poter effettuare il login da CLI.
Successivamente basterà effettuare l'operazione di pull per ottenere l'immagine dalla repository ed esegurila tramite i comandi riportato sotto.


```bash
sudo docker login --username <yourusername>

...

sudo docker pull mastronardo/publicity-bot-mst
sudo docker exec -it publicity-bot-mst-publicity-bot-mst-1 bash
```
