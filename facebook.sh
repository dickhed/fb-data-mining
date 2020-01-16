#!/bin/bash
#
# -------------------------------------------------------------
#
# Title: statements about facebook posts based on a data set
#
# Requirements: awk, csvkit
#
# Autoren: Michael Bertschi, Jan Minder, Rehan Mirza
# Version: 1.0
# Datum: 23. Januar 2020
#
# -------------------------------------------------------------


# Variablen
TITLE="**** Facebook Data Mining ****"
FB_DATA="./facebook.csv"

# Functions

# Michi
function data_preview {
  echo "Implement Data Preview"
}

# Rehan
function state_count {
  echo "Implement Stati Count"
}

# Jan
function popular_post {

    # calculates the Column 8 - 15 of each line with awk
    # sorts the output from awk based on second column
    # take the first result with head
    # columns with wrong data (eg. a date) will be count as 0
    printf "\nMost Popular Post from all Data:\n\n"
    awk  -F "\"*,\"*" '{
        printf "Likes: %d   |   Post: %s    |   ID: %s \n", int($8  + $9 + $11 + $12 + $13 + $14 + $15), $2, $1
        }' $FB_DATA \
    | sort -gk 2 -r \
    | head -1
    printf "\n"

}

# -- Menu -----------------------------------

# Der Array fuer das Menu
MENU=(
"Datenpreview anzeigen"
"Auswertung aller Stati pro Typ"
"Belibtesten Eintrag anzeigen"
"Ende"
)

# Anzahl Elemente des Arrays MENU
ANZAHL=${#MENU[*]}

# Beginn des Programmes
# Schlaufe fuer das Menue
while true; do
  # Menu ausgeben
  echo "---------------------------------"
  echo "$TITLE"
  echo "---------------------------------"
  printf "\n"
  for ((i=0; $i<$ANZAHL; i=$i+1)); do
    echo "$i) ${MENU[$i]}"
  done
  printf "\n"

  # Eingabe verlangen und einlesen
  echo -n "Auswahl eingeben, mit ENTER bestaetigen: "
  read ANTWORT
  # case Anweisung - je nach Eingabe Verhalten bestimmen
  case $ANTWORT in
  0) # wenn die Antort 1 ist tue dies
    echo -e "\n=> ${MENU[0]}\n"
    data_preview
    echo ""
    ;;
  1) # dasselbe fuer die Antwort 2
    echo -e "\n=> ${MENU[1]}\n"
    state_count
    ;;
  2) # dasselbe fuer die Antwort 2
    echo -e "\n=> ${MENU[2]}\n"
    popular_post
    ;;
  3|[eE]|[qQ]) # regulaerer Ausdruck, behandelt sowohl 2 als auch e/E oder q/Q
    echo -e "\n=> ${MENU[3]}\n"
    break # while Schleife beenden
    ;;
  *) # bei allen anderen Antworten kommt dieser Block zum Zug
    echo -e "\n=> Ungueltige Eingabe\n"
    ;;
  esac
done