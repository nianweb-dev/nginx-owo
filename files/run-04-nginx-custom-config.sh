#!/bin/bash
set -o pipefail
set -o errexit
set -x 
mkdir /etc/nginx/modules-enabled
mkdir /etc/nginx/sites-enabled
mkdir /etc/nginx/conf.d
mkdir /etc/nginx/conf-root.d
rm /etc/nginx/nginx.conf
mv /nginx.conf /etc/nginx/nginx.conf

#forward nginx log to docker logs
ln -s /dev/stdout /etc/nginx/logs/access.log
ln -s /dev/stderr /etc/nginx/logs/error.log
