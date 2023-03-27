#!/bin/bash
set -o errexit
set -o pipefail
set -x
for script in $(ls -1 /run-*.sh)
do
    bash /${script}
done
rm /run-*.sh
rm /build.sh
