#!/bin/bash
#--------------------------------
# for creating cscope database
#--------------------------------
project_name=${PWD##*/}
project_dir=${PWD}

#cscopeDB_folder=.cscope_db
ctag_folder=${tagAndDB_dir}
ctag_file=myCtags

#echo ${project_name}
#echo ${project_dir}/${cscopeDB_folder}
#source ${BACKSRC_PROJ_DIR}/backup.conf
#echo $BACKUP_DEST

if [ ! -d ${project_dir}/${ctag_folder} ]
then
	mkdir ${project_dir}/${ctag_folder}
fi

#ctags -R --c++-kinds=+p --fields=+iaS --extra=+qi .
#ctags -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include

ctags --tag-relative=yes -R -f ${project_dir}/${ctag_folder}/${ctag_file} . --c++-kinds=+p --fields=+iaS --extra=+q /usr/include


echo "Finish creating ctags"
