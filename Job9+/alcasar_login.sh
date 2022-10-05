#!/bin/zsh

# Job 9+ (Pour aller plus loin...)
# -----------------------------------
# Pour finir ce sujet en beauté 😎, vous allez essayer de créer un script qui vous permettra
# de vous connecter à Alcasar en utilisant exclusivement les lignes de commandes et
# sans ouvrir la page alcasar.
#
# Votre script devra se lancer de telle sorte :
# ./alcasar_login email password
# -----------------------------------
# ⚠️  ATTN: This code is not finished :)
# ===================================



# Initializing some "ALCASAR" constants...:)

URL="https://alcasar.laplateforme.io/intercept.php" # <- recently added just for testing purposes :(

ALCASAR_URL="https://alcasar.laplateforme.io"
ALCASAR_PORT=3991
ALCASAR_LOGIN_URL="$ALCASAR_URL:$ALCASAR_PORT/intercept.php" # <- intercept.php or logon ?
ALCASAR_LOGOUT_URL="$ALCASAR_URL:$ALCASAR_PORT/logoff"


# Defining the `username` and `password` variables...

# Get the `username` 
# as the first argument
username=$1
# Get the `password` 
# as the second argument
password=$2

# If no arguments were provided...
if [[ $# -eq 0 ]]; then
    # ... display a welcome message and prompt the user
    # to enter his/her username and password
    printf "\n\x1b[36m%s\x1b[0m\n" "========== ALCASAR =========="
    printf "%s\n\n" "Enter your login details"
    # username (eg. abraham.ukachi@laplateforme.io)
    printf "\x1b[1m%s\x1b[0m \x1b[2m%s\x1b[0m\n" "Username:" "[prenom.nom@laplateforme.io]"
    printf "\x1b[36m↳\x1b[0m "
    read -r username # <- this will update the `username` variable
    # password (eg. ABC123!@#)
    printf "\x1b[1m%s\x1b[0m \x1b[2m%s\x1b[0m\n" "Password:" "[ABC123!@#]"
    printf "\x1b[36m↳\x1b[0m "
    read -r password # <- this will update the `password` variable
    printf "\n\n"
fi



# HTTP_CODE=$(curl --write-out "%{http_code}\n" "https://alcasar.laplateforme.io:3991/intercept.php" --output output.txt --silent)
# echo $HTTP_CODE

# Returns the value of the given `key` from the given `xml`.
# - param_1: xml
# - param_2: key
# < returns: value
function get_xml_value {
    local xml=$1
    local key=$2
    
    
    value=`printf '%s\n' "$xml" | grep "$key" | xmlstarlet sel -t -v "$key"`
    # return the value 
    echo $value
} 

# TODO 1: Handle atleast 2 more logout options like `-l`, `--logoff`, etc.
# TODO 2: Create a `logout` function

if [[ $1 == "--logout" ]]; then
    
    # Log the user OUT of alcasar
    #xml=$(curl -k --silent -iL $ALCASAR_LOGOUT_URL)
    xml=$(curl -iL $ALCASAR_LOGOUT_URL --silent)
    # Create a `log` folder if it doesn't already exist
    mkdir -p "log"
    # Append the response to the a `logout-[date:time].log` file
    echo "$xml" >> "log/logout-$(date '+%d-%m-%Y__%H:%M:%S').log"

    # Get the `MessageType` from the xml
    message_type=$(get_xml_value $xml "MessageType")
    # Get the `ResponseCode` from xml
    response_code=$(get_xml_value $xml "ResponseCode")
    # Get the `ReplyMessage` from xml
    reply_message=$(get_xml_value $xml "ReplyMessage")

    # LOG: Tell dbsmaster about these values :)
    printf "MessageType: %s\n" $message_type
    printf "ResponseCode: %s\n" $response_code
    printf "ReplyMessage: %s\n" $reply_message
    
    # Tell the world that this user has been logged out of alcasar successfully :)
    printf "[alcasar] ($response_code): \x1b[35mYou've been logged out successfully!!!\x1b[0m\n"

else
    # Try to login to **alcasar** with the given `username` & `password`
    # TODO: Create a `login` function
    
    # Log the user into alcasar
    # xml=$(curl -k --silent -iL "$ALCASAR_LOGIN_URL?username=$username&password=$password")
    
    xml=$(curl -iL -d "username=$username" -d "password=$password" "$ALCASAR_LOGIN_URL" --silent)

    # Create a `log` folder if it doesn't already exist
    mkdir -p "log"
    # Append the response to a `login-[date:time].log` file
    echo "$xml" >> "log/login-$(date '+%d-%m-%Y__%H:%M:%S').log"
    
    # Get the `MessageType` from the xml
    message_type=$(get_xml_value $xml "MessageType")
    # Get the `ResponseCode` from xml
    response_code=$(get_xml_value $xml "ResponseCode")
    # Get the `ReplyMessage` from xml
    reply_message=$(get_xml_value $xml "ReplyMessage")

    # LOG: Tell dbsmaster about these values :)
    printf "MessageType: %s\n" $message_type
    printf "ResponseCode: %s\n" $response_code
    printf "ReplyMessage: %s\n" $reply_message
 
    # Tell the world that this user has been logged in to alcasar successfully :)
    printf "[alcasar] ($response_code): \x1b[1m$reply_message\x1b[0m\n"

fi

# username: abraham.ukachi@laplateforme.ip
# password: *******
#
# curl -X POST https://alcasar.laplateforme.io/intercept.php
#   -H "Content-Type: application/x-www-form-urlencoded"
#   -d "challenge=25846dfdb8e4e1ad527a6c6bd3d2fd57
#   &userurl=http://www.euronews.com/
#   &username=abraham.ukachi@laplateforme.io
#   &password=***********
#   &button=Authentication"
