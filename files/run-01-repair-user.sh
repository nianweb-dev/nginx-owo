#!/bin/bash
NGINX_USER=www-data
NGINX_PUID=33
set -o errexit
set -o pipefail
set -x
get_user_name(){
	cat /etc/passwd |grep :${1} | cut -d ":" -f 1
}
get_group_name(){
	cat /etc/group |grep ${1}: |cut -d ":" -f 1
}

if [ -z $(get_user_name ${NGINX_PUID}) ]
	then
		true
	else
		deluser $(get_user_name ${NGINX_PUID})
fi

if [ -z $(get_group_name ${NGINX_USER}) ]
	then
		true
	else
		delgroup  $(get_group_name ${NGINX_USER})
fi

addgroup -g ${NGINX_PUID} -S ${NGINX_USER}
adduser -S -D -H -u ${NGINX_PUID} -G ${NGINX_USER} ${NGINX_USER}
echo success run script $0
