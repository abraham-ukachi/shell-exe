#!/bin/zsh

# Job 5
# ----------------------------------
# Vous allez maintenant voir les conditions, pour cela il vous faut réaliser un script qui
# affichera soit “Bonjour, je suis un script !” soit “Au revoir et bonne journée” selon
# l’argument passé.
#
# Le paramètre “Hello” devra afficher le message “Bonjour ......” et “Bye” devra afficher le
# message “Au revoir ......”
#
# Votre script devra se nommer hello_bye.sh et se lancera de cette façon :
# ./hello_bye.sh Bye
# ----------------------------------


if [[ "$1" == "Hello" ]]; then
    # If the *first* argument is equals to `Hello`,
    # display the following message: "Bonjour ......"
    echo "Bonjour ......";
elif [[ "$1" == "Bye" ]]; then
    # However, if the *first* argument is equals to `Bye`,
    # display the following message: "Au revoir ......"
    echo "Au revoir ......";
fi


