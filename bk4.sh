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
# ??
# script soll den www ordner auslesen und jeden order ausser 
# BLB backupen sowie einen mysql dump erstellen von allen DBs
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

#Variablen
owntag=core
mp4tag=mp4
mkvtag=mkv

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
        echo "$DirPath"
#        newtag=${DirPath%.XXX*}
#        newfile=${file%.*}
#        ffmpeg -i $file -c copy -metadata title="$newtag" -metadata comment="$newtag" -y ${newfile}_${owntag}.${mp4tag}
        echo $file gefunden.
#        rm $file
  done
#  find "$file" -type f -not -name ".*" | grep .mp4$ | while read file
#  do
#        newfile=${file%_core.*}
#        mv $file ${newfile}.${mp4tag}
#        echo $file verschoben.
#   done
done
