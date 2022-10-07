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

# Get the content of the csv file
# CSV_FILE_CONTENT=`cat $CSV_FILE`

# TODO: Create an option (-r or --remove) to delete all previously created users.
DELETE_USER_OPT=$2

# TODO: Create and `admin_list` array


# Do nothing if the csv file doesn't exist
# if [[ -f $CSV_FILE ]]; then
#    exit 1;
# fi


# Returns 0 (true) if the user is an administrator
# HACK: This is temp solution to a problem. FIND ANOTHER WAY !!!
# - param_1: id
# function check_admin_by_id {
#    local id=$1
#    
#    result=`cat $CSV_FILE | grep $id | grep Admin`
#    
#    [[ -z $result ]] && return false || return true
#
#    # If the result is empty ...
#    # if [[ -z $result ]]; then
#    #    # ...return 0 (true) 'cause the user is an admin
#    #    return true;
#    # fi
#    
#    # return 1
# }
#


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
    # Let's trim the username (ie. remove any leading and/or trailing space - aka.: whitespace)
    username=`echo $username | sed 's/ //g'` 
    
    # Creating a new user on macOS... 
    # TODO: Create a home directory for this new user (ie. NFSHOMEDIRECTORY) 
    
    # Unique ID: Add the `username` to list of Users w/ a unique `id`
    sudo dscl . -create "/Users/$username" UniqueID $id
    # Password: Create the user's password with the given `mdp` (mot de passe)
    sudo dscl . -passwd "/Users/$username" "$mdp"
    # UserShell: Oh my zsh!! Ofcourse we want our user to use `zsh` LOL :)
    sudo dscl . -create "/Users/$username" UserShell /bin/zsh
    # RealName: Add the user's fullname
    sudo dscl . -create "/Users/$username" RealName "$prenom $nom"
    # PrimaryGroupID: Set the user's primary group id to 20 (custom)
    # TODO: Use the given `id` as primary group ID too ?
    sudo dscl . -create "/Users/$username" PrimaryGroupID 20 
    
    # role=`echo $`
    # echo -n "echo -n role >>> --$role-- [${#role}]\n"
    # sleep 2
    # echo "echo role => --$role-- [${#role}]"

    # echo "$username is an adminstrator $role]" >> access_logs.txt
    
    # is_admin=`check_admin_by_id $id`

    # role_len=`echo $role | wc -m`
    # echo "$role => $role_len"

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
    # Do nothing or continue to the next loop,
    # if the value of `id` is `Id` (ie. the header or first line)
    # if [[ $id == "Id" ]]; then
    #    continue
    # fi
    
    
    # If a delete user option was given (ie. "-r")...
    if [[ $DELETE_USER_OPT == "-r" ]]; then
        # ...delete this user
        delete_user_macos $id $prenom $nom

        # TODO: Print out the total number of users deleted
    else
        # However, if there's no "-r" option...
        # Create a user on macOS  with the given `id`, `prenom`, `nom` and `m`
        create_user_macos $id $prenom $nom $mdp $role

        # TODO: Print out the total number of users created
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

