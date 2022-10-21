# prendo un immagine di python da docker hub
FROM python:3.10.8-slim-buster

RUN apt update && apt install cron nano -y && apt upgrade -y 

# creo le directory del bot e del log
RUN mkdir /publicity-bot /log

# copio i file nel container filtrati dal .dockerignore e rendo /publicity-bot la directory di lavoro
COPY . /publicity-bot/
WORKDIR /publicity-bot

RUN pip3 install --upgrade pip && pip3 install -r /publicity-bot/requirements.txt

# è il primo comando eseguito dal container
ENTRYPOINT ["sh","-c","/publicity-bot/scripts/entrypoint.sh"]
