#!/bin/bash

backup_dir=/tmp/backups

#общее количество параметров, переданных скрипту, + STDERR

if [ "$#" -ne 2 ]; then
    echo "Incorrect number of parameters!" >&2
    exit 1
fi

#проверка того, что 1ый параметр - директория, + STDERR
if [ ! -d "$1" ]; then
    echo "This directory does not exist!" >&2
    exit 2 
fi

#проверка того, что 2ое значение - число, + STDERR
amount='^[0-9]+$'
if ! [[ $2 =~ $amount ]] ; then
   echo "The second parameter is not a number!" >&2;
     exit 3
fi
 
#создать директорию, если её еще не существует 
[ -d $backup_dir ] || mkdir $backup_dir

#“/” в пути директории должен заменяться на “-”, а корневой каталог в пути - отбрасываться
backup_name=${1//\//-}
date=$(date '+%Y-%m-%d-%H-%M-%S')
backup_name=${backup_name// /"\ "}
backup_name=${backup_name/-/}
echo $backup_name

#Файлы бекапов должны быть запакованы tar
tar czf "$backup_dir"/"$backup_name"-"$date".tar.gz "$1" || { echo "Tar Command Error!" >&2 ; exit 4; }
backups_count=$(ls "$backup_dir"/"$backup_name"-*.tar.gz | wc -l)
echo $backups_count
echo $(($backups_count-$2))


#Удалять старые бэкапы, исходя из второго параметра ввода
if (($backups_count-$2 > 0)); then
{ ls -t "$backup_dir"/"$backup_name"-*.tar.gz |tail -n $(($backups_count-$2)) | xargs -d '\n' -r rm; } || { echo "Backup Delete Command Error!" >&2 ; exit 5; }
else
echo "Backups are stored!"
fi
