#! /bin/bash
set -o nounset
set -o errexit
set -x
# This is the backup shell script only for docker container "PortableTrac".
#   - https://github.com/thinkbase/Dockerfiles/tree/master/09-Apps/01-PortableTrac

export SITE_BASE=/data
/home/u01/github/PortableTrac/trac-backup.sh main
/home/u01/github/PortableTrac/trac-backup.sh trac
