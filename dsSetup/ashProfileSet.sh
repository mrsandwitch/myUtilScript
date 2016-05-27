#!/bin/sh

ash_profile_file=ash_profile
dst_profile_path=/root/.profile

cat ${ash_profile_file} >> ${dst_profile_path}

echo "Finsh copy profile to DS"
