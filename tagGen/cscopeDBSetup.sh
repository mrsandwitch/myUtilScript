#!/bin/bash
#--------------------------------
# for creating cscope database
#--------------------------------
project_name=${PWD##*/}
project_dir=${PWD}

#cscopeDB_folder=.cscope_db
cscopeDB_folder=${tagAndDB_dir}
cscopeGen_file=cscope.files

#echo ${project_name}
#echo ${project_dir}/${cscopeDB_folder}
#source ${BACKSRC_PROJ_DIR}/backup.conf
#echo $BACKUP_DEST

if [ ! -d ${project_dir}/${cscopeDB_folder} ]
then
	mkdir ${project_dir}/${cscopeDB_folder}
	#find "`pwd`" -path "`pwd`/.*" -prune -o \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -print > ${cscopeDB_folder}/${cscopeGen_file}
fi

find "`pwd`" -path "`pwd`/.*" -prune -o \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -print > ${cscopeDB_folder}/${cscopeGen_file}
cd ${project_dir}/${cscopeDB_folder}
cscope -Rbq -i ${cscopeGen_file}


echo "Finish creating cscope database"
