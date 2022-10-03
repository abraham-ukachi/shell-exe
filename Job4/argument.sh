#!/bin/zsh

# Job4
# -----------------------------------------
# Pour ce job, votre script devra créer un fichier dans le répertoire courant qui prendra \
# le nom passé en premier argument. Il devra prendre en deuxième argument le nom d’un \
# fichier dont il se servira pour remplir celui que vous venez de créer. \
# Pour réaliser ce job, vous devrez utiliser obligatoirement les redirections. \
# Votre script se nommera argument.sh et se lancera de la manière suivante : \
# ./argument.sh myfile.txt copyfile.txt
# -----------------------------------------


# Get a file's name from the first argument
# Example: "myfile.txt"
fileName=$1
# Get the name of our 'copy file' from the second argument
# Example: "copyfile.txt"
copyFileName=$2

# Copy the contents of our 'copy file' into a new file w/ the given `fileName`
cat $copyFileName > $fileName
