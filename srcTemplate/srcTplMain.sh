#!/bin/bash
#- Script to manage source code template
#- bashrc setting
#export TEMPLATE_SCRIPT_DIR=/synosrc/myUtilScript/srcTemplate
#alias tmpScript="bash ${TEMPLATE_SCRIPT_DIR}/srcTplMain.sh"

#project_name=${PWD##*/}
template_dst_dir=${PWD}
template_src_dir=$(dirname ${0})/templates
template_list_name=template_list.md
template_list=${template_src_dir}/${template_list_name}

function printUsage(){
	printf "\n"
	echo '-l list all template'
	echo '-v Use vim view that template'
	echo '-vc show that template in terminal'
	echo '-c copy that template to current directory and open with vim'
	echo '-cw copy that template to current directory without vim viewing'
	echo '-e Use vim open template and edit'
	echo '-h show help message'
	echo '-u update current available templates'
	echo '-s save current file as templates'
	printf "\n"
}

function listTemp()
{
	printf "\n";	
	cat ${template_list};
	printf "\n";	
}

function viewTemp(){
	vim -R ${template_src_dir}/${1} 
}

function viewCatTemp()
{
	cat ${template_src_dir}/${1} 
}

function editTemp()
{
	vim ${template_src_dir}/${1} 
}

function cloneTemp()
{
	cp -av ${template_src_dir}/${1} ${template_dst_dir} 
}

function cloneAndEdit()
{
	cp -av ${template_src_dir}/${1} ${template_dst_dir} 
	vim ${template_dst_dir}/${1}
}

function saveTemp()
{
	cp -av ${template_dst_dir}/${1} ${template_src_dir} 
	vim ${template_src_dir}/${1}
}

function updateList()
{
	echo "List of available template:" > ${template_list}
	for tmp in $(ls ${template_src_dir})
	do
		if [ ${tmp} == ${template_list_name} ] 
		then
			continue;
		fi
		echo -n "${tmp} " >> ${template_list}
		sed '2q;d' ${template_src_dir}/${tmp} >> ${template_list}
	done
}

case ${1} in
	-h)
		printUsage
		;;
	-l)
		listTemp
		;;
	-v)
		viewTemp ${2}
		;;
	-vc)
		viewCatTemp ${2}
		;;
	-e)
		editTemp ${2}
		;;
	-u)
		updateList
		;;
	-cw)
		cloneTemp ${2}
		;;
	-c)
		cloneAndEdit ${2}
		;;
	-s)
		saveTemp ${2}
		;;
	*)
		echo "wrong input"
		;;
esac



