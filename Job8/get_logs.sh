#!/bin/zsh

# Job 8
# --------------------------
# Maintenant que vous connaissez les boucles, vous devez utiliser les Cron pour
# permettre d’exécuter ce script toutes les heures.
#
# Ce script aura pour but d’extraire de vos logs Linux le nombre de connexions à votre
# session qui ont eu lieu sur votre ordinateur. Ce nombre sera écrit dans un fichier qui se
# nommera number_connection-Date où Date sera remplacé par la date de création de
# votre fichier avec l’heure sous le format jj-mm-aaaa-HH:MM.
#
# Par la suite, ce fichier devra être archivé avec tar et déplacé dans un sous-dossier
# appelé Backup.
#
# Votre fichier script devra se nommer get_logs.sh
#
# Votre arborescence sera donc Job8 → Backup → number_connection-Date
# -----------------------------



# Let's initialize some constants & variables first, shall we ? :-)

# Define the required format for `date` (ie. dd-mm-yyyy-HH:MM)
DATE_FORMAT='%d-%m-%Y-%H:%M' # <- `man date` was very useful for this.
# Get the logs - a list of session connections that took place on this Linux host
logs=`who` # <- NOTE: Commands like `last`, `finger` or `w` can also be used.
# Get the number of connections from `logs` as `num_con`
num_con=`echo $logs | wc -l`
# Create a file name  with the current date & time, using the predefined `DATE_FORMAT`
filename="number_connection-$(date +$DATE_FORMAT)"

# TODO: Delete the code snippet below
# TXT_FILE_TXT="$filename.txt"
# TAR_FILE_TAR="$filname.tar"

# Insert `num_con` into a newly created '.txt' file
echo $num_con > "$filename.txt"

# Safely create a "Backup" folder in the current working directory
mkdir -p 'Backup'

# Create a tar archive of `file` of our '.txt' file
# and save it into the "Backup" folder
tar -cf "Backup/$filename.tar" "$filename.txt"

# Tell the world that the '.tar' file has been saved in 'Backup' folder
printf "\x1b[32m%s\x1b[0m %s \x1b[1m%s\x1b[0m %s \x1b[1m\x1b[32m%s\x1b[0m\n" "[i]" "log saved in" "Backup" "as:" "$filename.tar"

# If there's no `--keep-file` or `-k` option as first argument...
if [[ "$1" != "--keep-file" ]]; then
    # ...remove the '.txt' file 
    rm "$filename.txt"
fi


