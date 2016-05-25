#!/bin/bash
#---------------------------
# for Generate doxygen document
# auto create a folder and config file
# Then run doxygen command
#---------------------------
project_name=${PWD##*/}
project_dir=${PWD}
project_config_file=proj_conf						#This is included by doxygen_config_file
doxygen_config_template=doxygen_config_template		#Can be genetated with doxygen -g, but need some altering
doxygen_config_file=doxygen_config

echo "Start to generate doxygen docs"
source ${DOXYGEN_SCRIPT_DIR}/doxygenSetup.conf		#Specify some setting Ex: document loaction

if [ ! -d ${DOC_DEST}/${project_name} ]
then
	mkdir ${DOC_DEST}/${project_name}
fi

cd ${DOC_DEST}/${project_name}
cp ${DOXYGEN_SCRIPT_DIR}/${doxygen_config_template} ./${doxygen_config_file}
#printf 'PROJECT_NAME\t=\t%s\nINPUT\t+=\t%s\n' ${project_name} ${project_dir} > ./${project_config_file}
printf 'PROJECT_NAME\t=\t%s\nINPUT\t+=\t%s\n' ${project_name} ${project_dir} > ./${project_config_file}
printf 'PREDEFINED\t+=\tSYNO_LIO_LUN_BACKUP' ${project_name} ${project_dir} >> ./${project_config_file}

# generate doxygen file
doxygen ${doxygen_config_file}

echo "Finish generating document"

