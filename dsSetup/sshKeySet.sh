#!/bin/sh

sshKey_dst_dir=/root/.ssh
ssh_key_file=authorized_keys
sshKey_src_path=authorized_pub_key

if [ ! -d ${sshKey_dst_dir} ]
then
	mkdir ${sshKey_dst_dir}
fi	

cat ${sshKey_src_path} >> ${sshKey_dst_dir}/${ssh_key_file}

echo "Finsh copy public key to DS"
