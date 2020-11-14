#Create a script. The script should do backup of /etc/ /var/www and /root and
#archivate this backup and save it to /home/ubuntu/backup/. 
#Name of the archive should be like backup_$date_$time. 
#Would be good if you can do this on flight using pipe.
#After you saved archive check the amount of the archives in the directory
#and if it is more than 5, remove oldest to reduce the amount to 5.

#!/bin/bash

backup_files="/etc /var/www /root" #что бэкапить

destination="/home/ubuntu/backup/" #куда бэкапить. 

day1=$(date +%A) #
time1=$(date +%T | tr ':' '_') 
#Вывод даты. В линуксе принято, что дата пишется через ":", что делает затруднительным распаковку архива.
#В данном случае все двоеточия заменены на "_", что является подходящим вариантом.

archive_file="$day1-$time1.tgz" #Name of the archive should be like backup_$date_$time.

echo "Backing Up $backup_files to $destination/$archive_file"
date
echo

tar czf $destination/$archive_file $backup_files #бэкап с использованим утилиты tar.

echo "Backup finished"
date

ls -lh $destination # Листинг файлов в $dest + проверка объема (в удобном формате -h)

cd /home/ubuntu/backup/
ls -t | sed -e '1,5d' | xargs rm -rf #remove oldest to reduce the amount to 5
