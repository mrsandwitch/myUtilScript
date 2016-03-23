#!/bin/bash
#---------------------------
# for backup
#---------------------------
target_name=${PWD##*/}

echo "hello"
echo ${target_name}
source ${BACKSRC_PROJ_DIR}/backup.conf
echo $BACKUP_DEST

if [ ! -d ${BACKUP_DEST}/${target_name} ]
then
	mkdir ${BACKUP_DEST}/${target_name}
fi	

find -path "/*" -prune -o \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -exec cp --parent {} ${BACKUP_DEST}/${target_name} \;

#find -path "/*" -prune -o \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -print -exec cp --parent {} ${BACKUP_DEST}/${target_name} \;
