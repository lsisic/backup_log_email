#!/bin/bash
#Luka Sisic 21.12.2017
[ ! -d /root/.backup ] && mkdir -p /root/.backup
TIME=$(date +%m-%d-%y)          
FILENAME=backup-$TIME.tar.gz   
SRCDIR=/usr/share/doc              
DESDIR=/root/.backup      
find $SRCDIR -type f -mtime +365 | xargs tar -cpzf $DESDIR/$FILENAME 
cd $DESDIR
read -a logovi <<< $(tar tzf back*)
for i in ${logovi[@]}; do echo "[ `date +"%m/%d/%y"`] backing up -  $i " >> /var/log/logloga ;done
if [ "$?" = "0" ]; then
        echo "Uspesan backup. Novi backup $FILENAME je kreiran" | mailx -s "OK" lukasisiccg@gmail.com
else
        echo "Backup nije uspeo. Kontaktirajte devops-a" | mailx -s "FAIL" lukasisiccg@gmail.com
        exit 1
fi
