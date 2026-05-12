#!/bin/bash

# Måste vara root
if [ "$EUID" -ne 0 ]; then
    echo "Kör som root!"
    exit 1
fi

# Måste skicka med namn
if [ $# -eq 0 ]; then
    echo "Skicka med användarnamn"
    exit 1
fi

# Lista alla användare
alla=$(cut -d: -f1 /etc/passwd)

for namn in "$@"
do
    useradd -m "$namn"
