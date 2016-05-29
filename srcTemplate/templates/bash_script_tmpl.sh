#!/bin/bash
#- Base Script template

# Optional alias to put in bashrc
#export TEMPLATE_SCRIPT_DIR=/synosrc/myUtilScript/srcTemplate
#alias tmpScript="bash ${TEMPLATE_SCRIPT_DIR}/srcTplMain.sh"

template_dst_dir=${PWD}
template_src_dir=$(dirname ${0})/templates
template_list_name=template_list.md
template_list=${template_src_dir}/${template_list_name}

function printUsage(){
	printf "\n"
	echo '-l list all template'
	echo '-v Use vim view that template'
	echo '-vc show that template in terminal'
	echo '-c copy that template to current directory'
	echo '-e Use vim open template and edit'
	echo '-h show help message'
	echo '-u update current available templates'
	printf "\n"
}

function listTemp()
{
	printf "\n";	
	cat ${template_list};
	printf "\n";	
}

function viewTemp(){
	vim ${template_src_dir}/${1} 
}

#Iterate through folder and cat name and second line to file
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
		sed '2q;d' ${tmp} >> ${template_list}
	done
}

#Script main
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
	-u)
		updateList
		;;
	*)
		echo "wrong input"
		;;
esac



