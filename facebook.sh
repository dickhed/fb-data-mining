#!/bin/bash

# Variablen
TITLE="**** Facebook Data Mining ****"



# Functions

# Michi / Aufgabe 7.1
function data_preview {
  echo "Implement Data Preview"
}

# Rehan / Aufgabe 7.2
function state_count {
  echo "Implement Stati Count"
}

# Jan / Aufgabe 7.3
function popular_post {
  echo "Implement Popular Post"
}

# Der Array fuer das Menu
MENU=(
"Datenpreview anzeigen"
"Auswertung: Anzahl Stati pro Type"
"Auswertung: Belibtester Eintrag"
"Ende"
)

# Anzahl Elemente des Arrays MENU
ANZAHL=${#MENU[*]}

# Beginn des Programmes
# Schlaufe fuer das Menue
while true; do
  # Menu ausgeben
  echo "$TITLE"
  for ((i=0; $i<$ANZAHL; i=$i+1)); do
    echo "$i) ${MENU[$i]}"
  done

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
    echo -e "\n=> ${MENU[1]}\n"
    popular_post
    ;;
  3|[eE]|[qQ]) # regulaerer Ausdruck, behandelt sowohl 2 als auch e/E oder q/Q
    echo -e "\n=> ${MENU[2]}\n"
    break # while Schleife beenden
    ;;
  *) # bei allen anderen Antworten kommt dieser Block zum Zug
    echo -e "\n=> Ungueltige Eingabe\n"
    ;;
  esac
done