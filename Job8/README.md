# Job 8
> - Author: [Abraham Ukachi](https://github.com/abraham-ukachi) 
> - Subject:[Shell-exe](https://github.com/abraham-ukachi/shell-exe)
> - School: [LaPlateforme\_](https://laplateforme.io)
> - Script: [get_logs.sh](./get_logs.sh)



## Description
> Original text in French: 
> Maintenant que vous connaissez les boucles, vous devez utiliser les Cron pour
> permettre d’exécuter ce script toutes les heures.
>
> Ce script aura pour but d’extraire de vos logs Linux le nombre de connexions à votre
> session qui ont eu lieu sur votre ordinateur. Ce nombre sera écrit dans un fichier qui se
> nommera number_connection-Date où Date sera remplacé par la date de création de
> votre fichier avec l’heure sous le format jj-mm-aaaa-HH:MM.
>
> Par la suite, ce fichier devra être archivé avec tar et déplacé dans un sous-dossier
> appelé Backup.
>
> Votre fichier script devra se nommer get_logs.sh
>
> Votre arborescence sera donc Job8 → Backup → number_connection-Date


Now that you know the loops, you must use Cron to run this script every hour. The purpose of this script is to extract from your Linux logs the number of connections to your session that took place on your computer. This number will be written in a file called number_connection-Date where Date will be replaced by the date your file was created with the time in the format dd-mm-yyyy-HH:MM.

Afterwards, this file will have to be archived with tar and moved to a subfolder called Backup. Your script file should be named **get_logs.sh**
Your tree will be Job8 Backup number_connection-Date



## Command line usage

Adding the cron job/task in **macron** to `crontab`:

```sh
crontab macron
```
> NOTE: This will allow `Cron` to run or execute our script (ie. `get_logs.sh`) every hour.


Or just execute the script from the current directory:

```sh
./get_logs.sh --keep-file
```
> `--keep-file`: This option keeps or NOT delete the **'.txt'** file after **'.tar'** has been saved in **Backup**. 



## Results
> NOTE: These are some giphy captures

### `get_logs.sh`
![Giphy Capture of get_logs.sh](./.screenshots/giphy_capture_1.gif)

### `macron`
![Giphy Capture of macron](./.screenshots/giphy_capture_2.gif)



## Issues

Not Yet ;)



## TODOs

- [ ] Optimize the [get_logs.sh](./get_logs.sh) script
- [ ] Remove unwanted comments
  
