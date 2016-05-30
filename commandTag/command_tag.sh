#!/bin/sh
#- Script to store and manage used command

# Optional alias to put in bashrc
#export COMMAND_TAG_DIR=/synosrc/myUtilScript/commandTag
#alias cmdTag="bash ${COMMAND_TAG_DIR}/command_tag.sh"

cmd_conf_file=$(dirname ${0})/command_tag.conf
cmd_db_dir=$(dirname ${0})/data
cmd_save=${cmd_db_dir}/saved_command
cur_ptr=${cmd_db_dir}/cur_ptr

function printUsage()
{
	printf "\n"
	echo '-h print usage message'
	echo '-s save command'
	echo '-e save and execute command'
	echo '-l list saved command(partial)'
	echo '-al list all saved command'
	echo '-m echo saved command as text'
	echo '-f flush all saved command'
	echo '-conf configure command tag script'
	echo '-N execute N-th saved command'
	printf "\n"
}

function save()
{
	cur_cmd=${@}
	if [ ! -f ${cmd_save} ]; then
		echo ${cur_cmd} > ${cmd_save}
	else
		sed -i "1i${cur_cmd}" ${cmd_save}
	fi
	
	stored_line_num=$(wc -l <${cmd_save})
	if [ ${stored_line_num} -gt ${max_line} ]; then
		sed -i "${max_line}d" ${cmd_save}
	fi
	echo "Success to store the command"
}

function saveAndExecute()
{
	cur_cmd=${@}
	save ${cur_cmd}
	${cur_cmd}
}

function list()
{
	printf "\n";	
	if [ -f ${cmd_save} ]; then
		head -${show_line} ${cmd_save} | cat -n
	else
		echo "There is no stored command"
	fi
	printf "\n";	
}

function listAll()
{
	printf "\n";	
	if [ -f ${cmd_save} ]; then
		cat -n ${cmd_save};
	else
		echo "There is no stored command"
	fi
	printf "\n";	
}

function flush(){
	rm ${cmd_save}
}

function executeNthCmd()
{
	#check whether input is a number
	re='^[0-9]+$'
	if ! [[ ${1} =~ ${re} ]] ; then
		echo "error: Not a number" >&2; exit 1
		return
	fi
	sel_cmd=$(sed "${1}q;d" ${cmd_save})
	${sel_cmd}
}

function echoCmd()
{
	#check whether input is a number
	re='^[0-9]+$'
	if ! [[ ${1} =~ ${re} ]] ; then
		echo "error: Not a number" >&2; exit 1
		return
	fi
	sel_cmd=$(sed "${1}q;d" ${cmd_save})
	echo ${sel_cmd} 
}

#Script main
source ${cmd_conf_file} 
if [ ! -d ${cmd_db_dir} ]; then
	mkdir $cmd_db_dir
fi

case ${1} in
	-h)
		printUsage
		;;
	-l)
		list
		;;
	-al)
		listAll
		;;
	-s)
		save ${@:2}
		;;
	-e)
		saveAndExecute ${@:2}
		;;
	-conf)
		vim ${cmd_conf_file}
		;;
	-f)
		flush
		;;
	-N)
		executeNthCmd ${2}
		;;
	-m)
		echoCmd ${@:2}
		;;
	*)
		echo "wrong input"
		;;
esac



