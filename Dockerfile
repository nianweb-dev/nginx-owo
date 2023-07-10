FROM alpine:latest
ADD files/* /
ENV NGINX_VERSION="1.24.0"
ENV NGINX_BUILD_TOOLS="git gcc g++ bash make"
ENV NGINX_BUILD_REQUIRE="pcre-dev openssl-dev zlib-dev perl-dev libxml2-dev libxslt-dev gd-dev geoip-dev"
RUN \
        cd / && \
	chmod 777 docker-entrypoint.sh && \
	apk --no-cache upgrade && \
	apk --no-cache add ${NGINX_BUILD_TOOLS} ${NGINX_BUILD_REQUIRE} && \
	mkdir build && \
	cd build && \
	bash /build.sh && \
	cd / && \
	rm -rf /build && \
	apk --no-cache del ${NGINX_BUILD_TOOLS}
STOPSIGNAL SIGQUIT
HEALTHCHECK CMD wget -T 3 -q -O - http://127.0.0.1:65534
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
