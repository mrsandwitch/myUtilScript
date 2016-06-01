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
	echo 'h         print usage message'
	echo 's         save command (at the end of line)'
	echo 'i         insert command (at first line)'
	echo 'w         overwrite command'
	echo 'm         echo saved command as text'
	echo 'e         save and execute command'
	echo '$[1-...]  execute N-th saved command'
	echo '                      '		
	echo '  @PAM to indicate input parameter'
	echo '  EX: cmdTag s echo @PAM'
	echo '      cmdTag 1 hello'
	echo '  hello'
	echo '                      '		
	echo 'l         list saved command(partial)'
	echo 'al        list all saved command'
	echo 'f         flush all saved command'
	echo 'conf      configure command tag script'
	printf "\n"
}

function save()
{
	cur_cmd=${@}
	echo ${cur_cmd} >> ${cmd_save}
	
	stored_line_num=$(wc -l <${cmd_save})
	if [ ${stored_line_num} -gt ${max_line} ]; then
		sed -i "${max_line}d" ${cmd_save}
	fi
	echo "Success to store the command"
}

function insert()
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
	echo "Success to insert the command"
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

function generateCmd()
{
	#check whether input is a number
	re='^[0-9]+$'
	if ! [[ ${1} =~ ${re} ]] ; then
		echo "error: Not a number" >&2;
		return
	fi
	sel_cmd=$(sed "${1}q;d" ${cmd_save})

	counter=0
	out_cmd=""
	args=("$@")
	for x in ${sel_cmd}; do
		if [ ${x} = "@PAM" ]; then
			let counter+=1
			out_cmd+=" ${args[${counter}]}"
		else
			out_cmd+=" $x"
		fi
	done
	echo ${out_cmd}
}

function executeNthCmd()
{
	sel_cmd=$(generateCmd ${@})
	echo ${sel_cmd} 
	${sel_cmd}
}

function echoCmd()
{
	sel_cmd=$(generateCmd ${@})
	echo ${sel_cmd} 
}

function overwriteCmd()
{
	overwrite_line=${1}
	cur_cmd=${@:2}

	if [ ! -f ${cmd_save} ]; then
		echo ${cur_cmd} > ${cmd_save}
	fi
	
	stored_line_num=$(wc -l <${cmd_save})
	if [ ${overwrite_line} -gt ${stored_line_num} ]; then
		echo "replacing line larger than current stored index"
		exit 1
	fi

	sed -i "${overwrite_line}s/.*/${cur_cmd}/g" ${cmd_save}

	list
	echo "Success to overwrite the command"
}

#Script main--------------------------
is_in_menu=true;
is_number=false;

source ${cmd_conf_file} 
if [ ! -d ${cmd_db_dir} ]; then
	mkdir $cmd_db_dir
fi

#check whether input is a number
re='^[0-9]+$'
if ! [[ ${1} =~ ${re} ]] ; then
	is_number=false
else executeNthCmd ${@:1}
	exit 0
fi

case ${1} in
	h)
		printUsage
		;;
	l)
		list
		;;
	al)
		listAll
		;;
	s)
		save ${@:2}
		;;
	i)
		insert ${@:2}
		;;
	e)
		saveAndExecute ${@:2}
		;;
	conf)
		vim ${cmd_conf_file}
		;;
	f)
		flush
		;;
	m)
		echoCmd ${@:2}
		;;
	w)
		overwriteCmd ${@:2}
		;;
	*)
		if [ "${is_number}" = false ]; then
			correct_input=false
		fi
		;;
esac


if [ "${correct_input}" = false ]; then
	echo "wrong input"
fi




