# Publicity bot mst

A causa dell'aumento della complessità di gestione di specifici problemi, workshop e conferenze, dei tool automatici ci vengono in soccorso. Questo progetto mira a inviare mail, con una specifica routine, tramite Google con un semplice programma a riga di comando.

# How to build it
Questa applicazione è nata a partire da ciò che è stato pubblicato dal Professore Carnevale all'interno del suo personale repository: lcarnevale/publicity-bot.
Basandomi su quanto è stato condiviso ho adattato il tutto per essere distribuibile tramite container.

Il progetto si basa sull'utilizzo del servizio SMTP di Gmail per inviare mail. Per permetterne l'utilizzo da CLI è necessario abilitare l'autentificazione a 2 fattori e generare una Password per le App per effettuare il login, in quanto dal 30 maggio 2022 Google non supporterà più l'uso di app di terze parti o dispositivi che chiedono di accedere all'Account Google utilizzando solo il nome utente e la password.

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

Per mandare mail seguendo una routine utilizziamo il demone di pianificazione dei lavori basato sul tempo, <b>Cron</b>. Cron viene eseguito in background e le operazioni pianificate, denominate "processi cron", vengono eseguite automaticamente.
I Cron job vengono registrati e gestiti in un file noto come crontab. Ciascun profilo utente sul sistema può avere il proprio crontab in cui programmare i lavori, che è archiviato in /var/spool/cron/crontabs/.

Per pianificare un job, apri crontab per la modifica e aggiungi un'attività scritta sotto forma di un'espressione cron. La sintassi per le espressioni cron può essere suddivisa in due elementi: la pianificazione e il comando da eseguire.

Il comando può essere praticamente qualsiasi comando che eseguiresti normalmente sulla riga di comando. La componente di pianificazione della sintassi è suddivisa in 5 diversi campi, che vengono scritti nel seguente ordine:


# How to use it
Dal punto di vista dell'utilizzatore è necessario, dapprima, registrarsi a Docker Hub, abilitare l'autentificazione a 2 fattori e infine generare un Access Token per poter effettuare il login da CLI.
Successivamente basterà effettuare l'operazione di pull per ottenere l'immagine dalla repository ed esegurila tramite i comandi riportato sotto.


```bash
sudo docker login --username <yourusername>

...

sudo docker pull mastronardo/publicity-bot-mst
sudo docker exec -it publicity-bot-mst-publicity-bot-mst-1 bash
```
