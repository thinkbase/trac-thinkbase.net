#! /bin/bash
if [ -z $BASH ]; then
    echo "This shell script MUST run under bash."
    exit -1
fi

set -o nounset
set -o errexit

gitUpdate(){
    local workFolder="/data/trac/tmp/git-work"
	local folder=$1
	local url=$2
	
	if [ ! -d "${workFolder}/${folder}" ]
	then
	    cd "${workFolder}"
	    git clone -v --progress ${url} ${folder}
	fi
	cd "${workFolder}/${folder}"
	git pull -v --progress
}

gitUpdate dev-thinkbase.net  https://github.com/thinkbase/dev-thinkbase.net.git
gitUpdate PortableTrac       https://github.com/thinkbase/PortableTrac.git

gitUpdate trac-thinkbase.net https://github.com/thinkbase/trac-thinkbase.net.git
