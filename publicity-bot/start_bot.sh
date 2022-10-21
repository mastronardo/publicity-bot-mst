#!/bin/bash

/usr/local/bin/python3 /publicity-bot/publicity-bot/main.py --host $HOST --port $PORT --from $MAIL --to /publicity-bot/publicity-bot/files/mailto.csv --cc /publicity-bot/publicity-bot/files/cc.csv --subject /publicity-bot/publicity-bot/files/subject.csv --body /publicity-bot/publicity-bot/files/body.csv
