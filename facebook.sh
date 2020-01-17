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
TITLE="|     Facebook Data Mining     |"
FB_DATA="data/facebook.csv"

# Colors
MENU_COLOR="\033[36m" # cyan
DEFAULT_COLOR="\033[37m" # white
PRIMARY_COLOR="\033[32m" # green
OUTPUT_COLOR="\033[33m" # yellow
ERROR_COLOR="\033[31m" # red


# Functions

# Michi / Aufgabe 7.1
function data_preview {
  echo "Implement Data Preview"
}

# Rehan / Aufgabe 7.2
function state_count {
  # sql query to count every status_id of each status_type
  # show the table of counted status_id's in each status_type
  csvsql --query "select count() as status_id, status_type from facebook group by status_type" data/facebook.csv | csvlook
}

# Jan / Aufgabe 7.3
function popular_post {

    # calculates the column 8 - 15 of each line with awk
    # sorts the output from awk based on likes column
    # take the first result with head 1
    # split the output with awk and add output styling
    
    # columns with wrong data (eg. a date) will be count as 0
    
    awk  -F "\"*,\"*" '{
        printf "%d|%s|%s|%s\n", int($8  + $9 + $11 + $12 + $13 + $14 + $15), $2, $1, $5
        }' $FB_DATA \
    | sort -gk 1 -r \
    | head -1 \
    | awk -v ocolor="${OUTPUT_COLOR}" -v pcolor="${PRIMARY_COLOR}" -v dcolor="${DEFAULT_COLOR}" '{
        split($0,a,"|"); 
        printf " Likes:   %s%d%s\n  Text:   %s%s%s\n    Id:   %s%s%s\n   Url:   %s%s%s", 
        pcolor, a[1], dcolor, ocolor, a[2], dcolor,  ocolor, a[3], dcolor, ocolor, a[4], dcolor}'
    printf "\n\n"

}

# -- Menu -----------------------------------

# Der Array fuer das Menu
MENU=(
"Datenpreview anzeigen"
"Auswertung: Anzahl Status-ID's pro Status-Typ"
"Auswertung: Belibtester Eintrag"
)

# Anzahl Elemente des Arrays MENU
ANZAHL=${#MENU[*]}

# Print Menu after each operation
while true; do
  # Print Menu
  printf "${MENU_COLOR}\n%s\n" "--------------------------------"
  printf "$TITLE\n"
  printf "%s${DEAULT_COLOR}\n\n" "--------------------------------"

  for ((i=0; $i<$ANZAHL; i=$i+1)); do
    printf "${MENU_COLOR} $i - ${MENU[$i]} ${DEFAULT_COLOR}\033[37m\n"
  done
  printf "\n"

  # Read selection
  echo -n "Confirm with ENTER key: "
  read ANTWORT


  case $ANTWORT in
  0) # data preview
    printf "\n${MENU_COLOR}%s${DEFAULT_COLOR}\n\n" "=> ${MENU[0]}"
    data_preview
    echo ""
    ;;
  1) # state count
    printf "\n${MENU_COLOR}%s${DEFAULT_COLOR}\n\n" "=> ${MENU[1]}"
    state_count
    ;;
  2) # popular post
    printf "\n${MENU_COLOR}%s${DEFAULT_COLOR}\n\n" "=> ${MENU[2]}"
    popular_post
    ;;
  3|[eE]|[qQ]) # regular expression, 3, e/E, q,Q
    printf "\n${PRIMARY_COLOR}%s${DEFAULT_COLOR}\n\n" "=> ${MENU[3]}"
    break # exit while loop
    ;;
  *) # any other keys
    printf "\n${ERROR_COLOR}%s${DEFAULT_COLOR}\n\n" "=> Invalid Input Selection"
    ;;
  esac
done