#!/bin/bash

# Kontrollera att scriptet körs som root
if [ "$EUID" -ne 0 ]; then
    echo "Du måste köra som root!"
    exit 1
fi

# Kontrollera att användarnamn skickats in
if [ $# -eq 0 ]; then
    echo "Användning: $0 user1 user2 ..."
    exit 1
fi

# Hämta alla befintliga användare
alla_anvandare=$(cut -d: -f1 /etc/passwd)

# Loopa igenom alla användare
for namn in "$@"
do
    # Skapa användare med hemkatalog
    useradd -m "$namn"

    # Skapa mappar
    mkdir /home/$namn/Documents
    mkdir /home/$namn/Downloads
    mkdir /home/$namn/Work

    # Sätt ägare
    chown -R $namn:$namn /home/$namn

    # Sätt rättigheter
    chmod 700 /home/$namn/Documents
    chmod 700 /home/$namn/Downloads
    chmod 700 /home/$namn/Work

    # Skapa welcome-fil
    echo "Välkommen $namn" > /home/$namn/welcome.txt
    echo "Andra användare:" >> /home/$namn/welcome.txt
    echo "$alla_anvandare" >> /home/$namn/welcome.txt

    # Rättigheter på filen
    chown $namn:$namn /home/$namn/welcome.txt
    chmod 600 /home/$namn/welcome.txt

done
   

