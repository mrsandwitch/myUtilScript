#!/bin/sh

ash_profile_file=ash_profile
dst_profile_path=/root/.profile
dir_color_setting=DIR_COLORS
dir_color_dst=/etc/DIR_COLORS

cat ${ash_profile_file} >> ${dst_profile_path}
cp ${dir_color_setting} ${dir_color_dst} 

source ${dst_profile_path}

echo "Finsh copy profile to DS"
