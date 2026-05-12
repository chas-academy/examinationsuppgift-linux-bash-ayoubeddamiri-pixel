#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Du måste köra som root!"
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "Användning: $0 user1 user2 ..."
    exit 1
fi

alla_anvandare=$(cut -d: -f1 /etc/passwd)

for namn in "$@"
do
    useradd -m "$namn"

   

