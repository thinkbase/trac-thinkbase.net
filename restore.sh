#! /bin/bash
set -o nounset
set -o errexit
set -x
# This is the restore shell script only for docker container "PortableTrac".
#   - https://github.com/thinkbase/Dockerfiles/tree/master/09-Apps/01-PortableTrac

export SITE_BASE=/data
/home/u01/github/PortableTrac/bin/do_restore.sh main
/home/u01/github/PortableTrac/bin/do_restore.sh trac
chmod -Rv g+rw /data/tracenv/*
