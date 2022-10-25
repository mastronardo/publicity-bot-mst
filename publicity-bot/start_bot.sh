#!/bin/bash
# eseguo il bot con i corretti parametri
if [ -f /publicity-bot/publicity-bot/files/cc.csv ]; then
/usr/local/bin/python3 /publicity-bot/publicity-bot/main.py --host $HOST --port $PORT --from $MAIL --to /publicity-bot/publicity-bot/files/mailto.csv --cc /publicity-bot/publicity-bot/files/cc.csv --subject /publicity-bot/publicity-bot/files/subject.csv --body /publicity-bot/publicity-bot/files/body.csv

else
/usr/local/bin/python3 /publicity-bot/publicity-bot/main.py --host $HOST --port $PORT --from $MAIL --to /publicity-bot/publicity-bot/files/mailto.csv --subject /publicity-bot/publicity-bot/files/subject.csv --body /publicity-bot/publicity-bot/files/body.csv
fi
