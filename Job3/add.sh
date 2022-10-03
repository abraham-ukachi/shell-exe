#!/bin/zsh

# Job3
# -----------------------------
# Créer un script nommé add.sh qui prendra cette fois-ci des paramètres en entrée de
# script. Ce script devra permettre d’additionner 2 nombres. Les nombres doivent être 
# renseignés en argument du script comme ceci :
# -> Result : 42
# ------------------------------

# Use the `bc` command - an arbitrary precision calculator language -
# to add the two given number arguments, and assign the value to a `result` variable
result=`bc <<< "$1 + $2"`

# Print out the `result`
printf "\x1b[1mResult :\x1b[0m %s\n" $result

