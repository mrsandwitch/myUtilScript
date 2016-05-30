#!/bin/sh

dst_profile_path=/root/.profile

ash ./sshKeySet.sh
ash ./vimrcSet.sh
ash ./ezPasswdSet.sh
ash ./ashProfileSet.sh
ash ./commandTagSet.sh

source ${dst_profile_path}

echo "Finsh setting all config"
