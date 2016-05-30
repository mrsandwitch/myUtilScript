#!/bin/sh

cmdTag_dir=~/commandTag
mounted_cmdTag_dir=~/myUtilScript/commandTag
dst_profile_path=/root/.profile

if [ ! -d ${cmdTag_dir} ]; then
	cp -r ${mounted_cmdTag_dir} ${cmdTag_dir}
fi

export_cmdTag_dir="export COMMAND_TAG_DIR=${cmdTag_dir}"
alias_string="alias cmdTag='sh ${cmdTag_dir}/command_tag.sh'"

echo ${export_cmdTag_dir} >> ${dst_profile_path}
echo ${alias_string} >> ${dst_profile_path}

echo "Finsh copy command tag script to DS"
