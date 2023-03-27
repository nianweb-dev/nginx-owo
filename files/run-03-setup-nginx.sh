#!/bin/bash
set -o pipefail
set -o errexit
set -x
#openssl_release=$(wget -qO- -t1 "https://api.github.com/repos/openssl/openssl/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')
	git clone --recursive https://github.com/aperezdc/ngx-fancyindex
        git clone --recursive https://github.com/arut/nginx-dav-ext-module
        git clone --recursive https://github.com/arut/nginx-rtmp-module
        git clone --recursive https://github.com/openresty/headers-more-nginx-module
        git clone --recursive https://github.com/leev/ngx_http_geoip2_module
        wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
	#wget https://github.com/openssl/openssl/releases/download/${openssl_release}/${openssl_release}.tar.gz
        tar xzf nginx-${NGINX_VERSION}.tar.gz
	#tar xzf ${openssl_release}.tar.gz
        cd nginx-${NGINX_VERSION}
        bash ./configure \
                --prefix=/etc/nginx \
                --sbin-path=/sbin/nginx \
                --modules-path=/etc/nginx/modules \
                --conf-path=/etc/nginx/nginx.conf \
                --pid-path=/var/run/nginx.pid \
                --lock-path=/var/run/nginx.lock \
                --http-client-body-temp-path=/var/cache/nginx/client_temp \
                --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
                --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
                --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
                --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
                --user=www-data \
                --group=www-data \
                --add-module=../ngx-fancyindex \
                --add-module=../nginx-dav-ext-module \
                --add-module=../nginx-rtmp-module \
                --add-module=../headers-more-nginx-module \
                --add-module=../ngx_http_geoip2_module \
                --with-select_module \
                --with-poll_module \
                --with-threads \
                --with-http_ssl_module \
                --with-http_v2_module \
                --with-http_realip_module \
                --with-http_addition_module \
                --with-http_xslt_module \
                --with-http_image_filter_module \
                --with-http_geoip_module \
                --with-http_sub_module \
                --with-http_dav_module \
                --with-http_flv_module \
                --with-http_mp4_module \
                --with-http_gunzip_module \
                --with-http_gzip_static_module \
                --with-http_auth_request_module \
                --with-http_random_index_module \
                --with-http_secure_link_module \
                --with-http_degradation_module \
                --with-http_slice_module \
                --with-http_stub_status_module \
                --with-http_perl_module \
                --with-mail \
                --with-mail_ssl_module \
                --with-stream \
                --with-stream_ssl_module \
                --with-stream_realip_module \
                --with-stream_geoip_module \
                --with-stream_ssl_preread_module \
                --with-compat \
                --with-pcre \
                --with-pcre-jit \
                --with-cc-opt="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC" \
                --with-ld-opt="-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie"
		#--with-openssl=../${openssl_release}
        make -j$(nproc)
	make -j$(nproc) install
