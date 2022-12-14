#!/bin/zsh

# Job 9
# -------------------------
# Créer un script nommé accessrights.sh qui depuis ce fichier CSV, récupère les
# informations des utilisateurs et les crée sur votre système.
# Si l’utilisateur est un admin., donnez-lui le rôle de super utilisateur de votre système
# Pour la suite, utilisez les cron pour permettre au script de se relancer automatiquement
# s'il y a un changement dans le fichier CSV. (Pour tester, je vous invite à modifier le fichier à la main).
# -------------------------


# Create a constant CSV_FILE
# If the first argument (ie. $1) is empty, use 'Shell_Userlist.csv' instead; 
# However, if the first argument it is NOT empty, use it obv :)
CSV_FILE=`if [[ -z $1 ]]; then echo 'Shell_Userlist.csv'; else echo $1; fi`
# ^^^DO THIS MAYBE: CSV_FILE=`[[ -z $1 ]] && echo 'Shell_Userlist.csv' || echo $1'`

# TODO: Create an option (-r or --remove) to delete all previously created users.
DELETE_USER_OPT=$2

# TODO: Create and `admin_list` array


# TODO: Create a `create_user` function that can create a user on Debian and Ubuntu.

# Define a `create_user_macos` function w/ the following 4 params:
# - param_1: id (uniqueID)
# - param_2: prenom (firstname)
# - param_3: nom (lastname)
# - param_4: mdp (password)
# - param_5: role (job position)
function create_user_macos {
    local id=$1
    local prenom=$2
    local nom=$3
    local mdp=$4
    local role=$5
    
    # Create a lowercased username with the given `prenom`
    username="${prenom:l}" # On `bash`, it would be => ${prenom,,} 
    # Let's trim the username (ie. remove any leading and/or 
    # trailing space - aka.: whitespace)
    username=`echo $username | sed 's/ //g'` 
    
    # TODO: Trim the users' firstname/prenom
    
    # TODO: Do nothing if user already exists

    # Creating a new user on macOS... 
    
    # Unique ID: Add the `username` to list of Users w/ a unique `id`
    sudo dscl . -create "/Users/$username" UniqueID $id
    # Password: Create the user's password with the given `mdp` (mot de passe)
    sudo dscl . -passwd "/Users/$username" "$mdp"
    # UserShell: Oh my zsh!! Ofcourse we want our user to use `zsh` LOL :)
    sudo dscl . -create "/Users/$username" UserShell /bin/zsh
    # RealName: Add the user's fullname
    sudo dscl . -create "/Users/$username" RealName "$prenom $nom"
    # PrimaryGroupID: Make this user part of the local staff (non-admin account)
    # by setting his/her primary group id to 20
    # TODO: Use the given `id` as primary group ID too ?
    sudo dscl . -create "/Users/$username" PrimaryGroupID 20 
    # NFSHomeDirectory: Create a home directory for this user
    sudo dscl . -create "/Users/$username" NFSHomeDirectory "/Users/$username"
    # Create the user's home directory, just in case `dscl` doesn't create one.
    sudo mkdir -p "/Users/$username"   
    #  making this user the owner of the his/her home directory...  
    #  It just makes sense, doesn't it? LOL
    sudo chown "${username}:staff" "/Users/$username"

    # If this user's role is 'Admin'...
    if [[ $role == 'Admin' ]]; then
        # ...make him/her a 'sudoer'(ie. add the user to the 'admin' group)
        sudo dscl . -append "/Groups/admin" GroupMembership $username 
        
        # TODO: add this person to the `admin_list` array that'll be declared above
        
        # Tell the world that this user is an admin
        # printf "%s\n" "$username is now an admin :)"
        
    fi

    # Tell the world that this user has been created successfully :)
    printf "\x1b[32m✔︎\x1b[0m [User Created] (\x1b[1m$username\x1b[0m|$id) 🍏: \x1b[32m$prenom $nom\x1b[0m\n"
}


# Deletes the user from a macOS
# This function will remove the user from the '/Users' list
# - param_1: id
# - param_2: prenom
# - param_3: nom
function delete_user_macos {
    local id=$1
    local prenom=$2
    local nom=$3

    # Define the username variable as a lowercased `prenom`
    username=${prenom:l}
    # Trim the username AGAIN ;)
    username=`echo $username | sed 's/ //g'`
    
    # TODO: Do nothing if the user has already been deleted

    # Delete the user
    sudo dscl . -delete "/Users/$username"

    # Tell the world that this user has been deleted :(
    printf "\x1b[31mX\x1b[0m [User Deleted] (\x1b[1m$username\x1b[0m|$id) 🍎: \x1b[31m$prenom $nom\x1b[0m\n"

}

# Parse the `CSV_FILE`...
# GOODTOKNOW: IFS = Internal Field Separator
# BUG: role is not behaving propery because of the 'invisible' "\r" trailing in each line 
while IFS="," read -r id prenom nom mdp role
do
    # If a delete user option was given (ie. "-r")...
    if [[ $DELETE_USER_OPT == "-r" ]]; then
        # ...delete this user
        delete_user_macos $id $prenom $nom

        # TODO: Print out the total number of users deleted
        
        # Update the logs
        echo "|> $(date -R) <| [-] (User Removed): ${prenom:l}" >> .logs.txt

    else
        # However, if there's no "-r" option...
        # Create a user on macOS  with the given `id`, `prenom`, `nom` and `m`
        create_user_macos $id $prenom $nom $mdp $role

        # TODO: Print out the total number of users created
        
        # Update the logs
        echo "|> $(date -R) <| [+] (New User): ${prenom:l}" >> .logs.txt
    fi

done < <(cat -v $CSV_FILE | tail -n +2 | sed 's/\^M//g') 
# ^^^^^^- The -v (visible) option tells `cat` to display non-printing characters like '^M'
#       - The -n +2 (line number) option tells `tail` to start reading at line number two.
#       - The s/\^M//g (command) regular expression tells `sed` to remove or replace '^M' \
#         (a non-printing character) with an empty '' string.
#       - The <(...) construct is called process substitution. It causes Bash to accept \
#         the output of a process as though it were coming from a file descriptor. This \
#         is then redirected into the while loop, providing the text that the read \
#         command will parse.

