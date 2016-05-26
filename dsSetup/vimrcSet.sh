#!/bin/sh

vim_conf_file=vimrc_conf
dst_vimrc_path=/etc/vimrc

src_bundle_dir=bundle_vim
dst_bundle_dir=/root/.vim/bundle

if [ ! -d ${dst_bundle_dir} ]
then
	mkdir -p ${dst_bundle_dir}
fi	

cp -r ${src_bundle_dir}/* ${dst_bundle_dir}
cat ${vim_conf_file} > ${dst_vimrc_path}

echo "Finsh copy vimrc to DS"
