FROM python:3.10.8-slim-buster

RUN apt update && apt install cron nano -y && apt upgrade -y && mkdir /publicity-bot /log

COPY . /publicity-bot/

WORKDIR /publicity-bot

RUN pip3 install --upgrade pip && pip3 install -r /publicity-bot/requirements.txt

ENTRYPOINT ["sh","-c","/publicity-bot/scripts/entrypoint.sh"]
