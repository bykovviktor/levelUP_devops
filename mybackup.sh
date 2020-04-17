#!/bin/bash

#files fot the backup

filelist=("/home/user/backup_script/myfiles/file1.txt" "/home/user/backup_script/myfiles/file2.py" "/home/user/backup_script/myfiles/file3.cfg")


#select directory, where files will be placed
backupdir="/home/user/backup_script/backup_folder" 

#maximum backup depth
backupdepth=3
 if ! [ -d ${backupdir} ]; then #check, thar dir with a file name is exist
  echo "BackupDir Doesn't exist. Please create it first"            #if no, then create a dir
 fi

for i in ${filelist[*]} 
do 
 filecount=0
 filename=$(basename "$i") #get name of the file from the path
 backupdate=$(date +"%y-%m-%d_%H-%M-%S") #date and time for the backup filename
 backupfilename="${filename}.${backupdate}.bak" #backup filename
 fullbackupfilename="${backupdir}/${filename}/${backupfilename}" 

 if ! [ -d ${backupdir}/${filename} ]; then #check, thar dir with a file name is exist
  mkdir ${backupdir}/${filename}            #if no, then create a dir
 fi

 filecount=$(ls "${backupdir}/${filename}" -l | grep "${filename}.*bak" | wc -l) #ckeck count of the files i the backup dir for the file. It should be no more then deckupdepth

 cp ${i} ${fullbackupfilename}  #copy file

 if (($filecount == 3)); then                                      #delete oldest backup if count of files more, than backupdepth
  oldestfile=$(ls "${backupdir}/${filename}/" -1rt | head -1)
  rm -rf "${backupdir}/${filename}/${oldestfile}"
 fi

done
