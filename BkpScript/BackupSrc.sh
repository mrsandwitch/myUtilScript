#!/bin/bash
#---------------------------
# for backup
#---------------------------
project_name=${PWD##*/}
project_dir=${PWD}

echo ${project_name}
source ${BACKSRC_PROJ_DIR}/backup.conf
echo $BACKUP_DEST

if [ ! -d ${BACKUP_DEST}/${project_name} ]
then
	git clone --local --no-hardlinks ${PWD} ${BACKUP_DEST}/${project_name}
	#mkdir ${BACKUP_DEST}/${target_name}
else
	cd ${BACKUP_DEST}/${project_name}
	git pull
	cd ${project_dir}
fi	

#find -path "/*" -prune -o \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -exec cp --parent {} ${BACKUP_DEST}/${target_name} \;

#find -path "/*" -prune -o \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -print -exec cp --parent {} ${BACKUP_DEST}/${target_name} \;
