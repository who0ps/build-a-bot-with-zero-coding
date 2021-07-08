#!/bin/bash

token="$1"
chat="$2"
subj="$3"
message="$4"

/usr/bin/curl -s -X POST -d "{\"auth_token\":\"${token}\", \"receiver\":\"${chat}\", \"sender.name\":\"alerter\", \"type\":\"text\", \"text\":\"${subj} ${message}\"}" https://chatapi.viber.com/pa/send_message
