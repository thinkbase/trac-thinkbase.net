#! /bin/bash

mkdir screenshot
echo "------------------------------------------------------------"

PRE_FILE="not-exist"

while(true); do
    ACTIVE_WIN_ID=`xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)"| cut -d ' ' -f 5`

    THE_WIN_ID=$ACTIVE_WIN_ID

    FILE_NAME=`date +%Y%m%d-%H%M%S`

    echo -ne "= \b"

    import -window $THE_WIN_ID -screen -frame screenshot/$FILE_NAME.png

    cmp -s screenshot/$FILE_NAME.png screenshot/$PRE_FILE.png
    if [ $? == 0 ] ; then
        echo -ne " [X]$PRE_FILE  \b"
        rm -f screenshot/$PRE_FILE.png
    fi

    PRE_FILE=$FILE_NAME

    sleep 1
done

