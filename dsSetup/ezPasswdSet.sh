#!/bin/sh

synouser --setpw bushyang a
synouser --setpw root a
synouser --modify admin admin 0 bushyang@synology.com
synouser --setpw admin a

echo "Finsh setting password DS"
