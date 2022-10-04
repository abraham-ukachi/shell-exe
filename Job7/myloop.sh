#!/bin/zsh

# Job 7
# --------------------------
# Il est désormais temps d’entrevoir le monde des boucles. Pour cela, vous allez créer un
# script nommé myloop.sh qui va afficher 10 fois la phrase suivante et afficher en fin de
# phrase un chiffre qui s’incrémente à chaque fois :
#
# “Je suis un script qui arrive à faire une boucle 1”
# “Je suis un script qui arrive à faire une boucle 2”
# “Je suis un script qui arrive à faire une boucle 3”
# “Je suis un script qui arrive à faire une boucle 4”
# ........
# “Je suis un script qui arrive à faire une boucle 10”
#
# Vous devez obligatoirement utiliser les boucles pour réaliser ce script.
# ----------------------------

# Define the message and number variables
# as `msg` and `num` respectively.
msg="Je suis un script qui arrive a fair un boucle"
num=0

# From 1 to 10...
for num in {1..10}; do
    # ...print the message followed 
    # by an incrementing yellow number ;)
    printf "%s \x1b[33m%s\x1b[0m\n" $msg $num
done

