#!/bin/bash

######################################################################
# bk4.sh
# simple backup-script www + mysql
######################################################################

######################################################################
# last modify: 11.08.2017
# bug or anything: d43M0n23@3xpl0it.com
######################################################################
# TODO EXAMPLE:
# create a *.bk4 file in the directory 4 backup-job
# like /home/dave/index.bk4 /home/mike/index.bk4
# the script make only a backup from directorys with bk4 files include
######################################################################
#
######################################################################
# Bash sTyl3!
clear='\033[0m'			#alle Attribute zurücksetzen
#red='\e[31m'
bold='\033[1m'			#Fettschrift
underline='\033[4m'		#Unterstreichen
blinken='\033[5m'		#Blinken
invers='\033[7m'		#inverse Darstellung
black='\033[30m'		#Schriftfarbe schwarz
red='\033[31m'			#Schriftfarbe rot
green='\033[32m'		#Schriftfarbe grün
yell='\033[33m'			#Schriftfarbe gelb
blue='\033[34m'			#Schriftfarbe blau
mag='\033[35m'			#Schriftfarbe magenta
turk='\033[36m'			#Schriftfarbe türkis
white='\033[37m'		#Schriftfarbe weiß
## B4ckgr0unD
bgblack='\033[40m'		#Hintergrund schwarz
bgred='\033[41m'		#Hintergrund rot
bggreen='\033[42m'		#Hintergrund grün
bgyell='\033[43m'		#Hintergrund gelb
bgblue='\033[44m'		#Hintergrund blau
bgmag='\033[45m'		#Hintergrund magenta
bgturk='\033[46m'		#Hintergrund türkis
bgwhite='\033[47m'		#Hintergrund weiß
#######################################################################

##Variablen
DATE=$(date +%F)

# Local Destination
DESTINATION=/full/path

# Database Backup User
#DATABASE=''
DATABASE_USER='root'
DATABASE_PASSWORD=$0
DATABASE_HOST='localhost'

# Tools install
#if ! hash exiftool 2>/dev/null; then sudo apt-get update && apt-get upgrade -y; sudo apt-get install --yes exiftool ; fi

# for file in *.bk4
# echo ${VALUE%.*}
for file in *;
do
  find "$file" -type f -not -name ".*" | grep .bk4$ | while read file
  do
    pfad=$(readlink -f "$file") # kpl. Pfad
        DirPath=$pfad
        DirPath="$(dirname $DirPath)"
        DirPath="$(basename $DirPath)"
	bk4dir=$DirPath
	#newfile=${file%.*}
	echo -e "\n${yell}Backup von $DirPath wird erstellt..${clear}"

	# Make The Weekly Backup
	tar -zcvf ${bk4dir}_${DATE}.tar.gz $bk4dir

	#Mysql *.bk4 auslesen und dump erstellen
	DATABASE=$(cat $file | grep mysql | cut -d ":" -f2)

	mysqldump -h $DATABASE_HOST -u $DATABASE_USER -p$DATABASE_PASSWORD $DATABASE > ${bk4dir}_${DATE}.sql
	if [ -f ${bk4dir}_${DATE}.sql ]; then
	echo -e "\n${bk4dir}_${DATE}.sql erstellt"
	tar -zcvf ${bk4dir}_${DATE}.sql.tar.gz ${bk4dir}_${DATE}.sql
	#rm ${bk4dir}_${DATE}.sql
	else
	echo -e "\nFehler bei SQL erstellung!"
	fi

echo "${red}Made ${bk4dir} weekly backup...${clear}"
  done
#find
done
exit
