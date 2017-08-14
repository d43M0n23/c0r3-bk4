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
#if ! hash ffmpeg 2>/dev/null; then sudo apt-get install --yes ffmpeg ; fi

#for file in *.mp4 *.mkv (Testen)
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
#        newfile=${file%.*}
	echo $DirPath

	# Make The Weekly Backup
	tar -zcvf ${bk4dir}_${DATE}.tar.gz $bk4dir

	#Mysql *.bk4 auslesen
	DATABASE=$(cat $file | grep mysql | cut -d ":" -f2)

	mysqldump -h $DATABASE_HOST -u $DATABASE_USER -p$DATABASE_PASSWORD $DATABASE > ${bk4dir}_${DATE}.sql
	if [ ! -f ${bk4dir}_${DATE}.sql ]; then
	echo "${bk4dir}_${DATE}.sql erstellt"
	else
	echo "Fehler bei SQL erstellung!"
	fi

echo "Made ${bk4dir} weekly backup..."
  done
#  find  bla bla 
done
exit
