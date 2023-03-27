#!/bin/ash
cache_dir="/var/cache/nginx/ /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp /var/cache/nginx/uwsgi_temp /var/cache/nginx/fastcgi_temp /var/cache/nginx/scgi_temp"
for _cache_dir in ${cache_dir}
do
	if [ -d ${_cache_dir} ]
	then
		true
	else
		echo "mkdir ${_cache_dir}"
		mkdir ${_cache_dir}
		chown www-data:root ${_cache_dir}
		chmod 700 ${_cache_dir}
	fi
done
/sbin/nginx -t
exec "$@"
