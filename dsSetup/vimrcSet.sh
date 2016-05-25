#!/bin/sh

vim_conf_file=vimrc_conf
dst_vimrc_path=/etc/vimrc

cat ${vim_conf_file} >> ${dst_vimrc_path}

echo "Finsh copy vimrc to DS"
