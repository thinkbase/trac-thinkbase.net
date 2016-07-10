#! /bin/bash
if [ -z $BASH ]; then
    echo "This shell script MUST run under bash."
    exit -1
fi

if [ ! -f "/private/git-tokens.conf" ]
then
    echo -e "***\n Clone ${url} into ${workFolder}/${folder} ... \n***"
    git clone -v --progress ${url} ${folder}
fi

set -o nounset
set -o errexit

# Read git push username/password from /private/git-tokens.conf
source /private/git-tokens.conf

rm -rfv /data/trac/backup/.old

cd /data/trac
./backup.sh
git status

git config user.name "oper1"
git config user.email "thinkbase-oper1@users.noreply.github.com"
git config push.default simple

git add --all .

set +o errexit  # commit should return non-zero if nothing could commit
git commit -m "Daily backup `date "+%Y%m%d-%H%M%S"`"
set -o errexit

git remote -v

git push https://${TOKEN_TRAC_THINKBASE_NET}@github.com/thinkbase/trac-thinkbase.net.git
