#!/bin/bash
set -o errexit
set -o pipefail
set -x
release=$(wget -qO- -t1 "https://api.github.com/repos/maxmind/libmaxminddb/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')
wget https://github.com/maxmind/libmaxminddb/releases/download/${release}/libmaxminddb-${release}.tar.gz
tar -xzf libmaxminddb-${release}.tar.gz
cd libmaxminddb-${release}
bash configure
make -j $(nproc)
make -j $(nproc) install

#fixme: ldconfig always return exitcode 1.
#ldconfig
echo success run script $0
