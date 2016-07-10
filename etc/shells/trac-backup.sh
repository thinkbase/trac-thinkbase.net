#! /bin/bash
if [ -z $BASH ]; then
    echo "This shell script MUST run under bash."
    exit -1
fi

set -o nounset
set -o errexit

# Read git push username/password from /private/git-tokens.conf
source /private/git-tokens.conf

set -x

rm -rfv /data/trac/backup/.old

cd /data/trac
# Before backup, pull the newest remote repo first
git pull
# Run trac backup, check git folder status
./backup.sh
git status

# Force update git configurations every time before commit
git config user.name "oper1"
git config user.email "thinkbase-oper1@users.noreply.github.com"
git config push.default simple

# Add changed files then commit
git add --all .
set +o errexit  # commit should return non-zero if nothing could commit
git commit -m "Daily backup `date "+%Y%m%d-%H%M%S"`"
set -o errexit

# Push to remote repo
git remote -v
set +x  #Hide the next command line to avoid password leak
git push https://${TOKEN_TRAC_THINKBASE_NET}@github.com/thinkbase/trac-thinkbase.net.git
