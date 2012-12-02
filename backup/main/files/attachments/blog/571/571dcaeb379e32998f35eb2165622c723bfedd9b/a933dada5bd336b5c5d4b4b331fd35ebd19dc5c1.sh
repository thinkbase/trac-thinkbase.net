#! /bin/bash

mkdir screenshot
echo "------------------------------------------------------------"

while :
do
    echo -ne "请选择需要录制的窗口 ...  \b"

    # 使用 xwininfo 选择一个窗口并获取其 window id
    xwininfo > screenshot/xwininfo.txt
    WIN_ID=`cat screenshot/xwininfo.txt | grep "xwininfo: Window id:" | cut -d ' ' -f 4`
    WIN_INFO=`xwininfo -id $WIN_ID | grep $WIN_ID`
    echo -e "选中的窗口是: \n  -> $WIN_INFO"

    # 当前需要截取的窗口对应的进程
    PID=`xprop -id $WIN_ID | grep "_NET_WM_PID(CARDINAL)" | cut -d ' ' -f 3`

    while(true); do
        read -p "请输入'y'确认, 输入'n'重新选择: " YES_NO
        case "$YES_NO" in
            [yY]*)
                THE_WIN_ID=$WIN_ID
                break
                ;;
            [nN]*)
                THE_WIN_ID="invalid"
                break
                ;;
            *)
                echo "输入($YES_NO)无效, 必须是 y 或者 n"
                ;;
        esac
    done

    if [ "$THE_WIN_ID" != "invalid" ]; then
        break
    fi
done

PRE_FILE="not-exist"

while(true);do
    # 获取当前活动窗口的 window id
    ACTIVE_WIN_ID=`xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)"| cut -d ' ' -f 5`
    # 获取当前活动窗口的 PID
    ACTIVE_PID=`xprop -id $ACTIVE_WIN_ID | grep "_NET_WM_PID(CARDINAL)" | cut -d ' ' -f 3`

    FILE_NAME=`date +%Y%m%d-%H%M%S`
    if [ "$ACTIVE_PID" == "$PID" ] ; then
        echo -ne "* \b"
        # 如果活动窗口属于当前进程, 截取活动窗口, 同时使用 -screen 参数, 以便保证界面上的菜单以及工具提示能够被正常截取下来
        import -window $ACTIVE_WIN_ID -screen -frame screenshot/$FILE_NAME.png
    else
        echo -ne ". \b"
        # 如果活动窗口不属于当前进程, 则截取所选择的窗口, 同时不使用 -screen 参数, 避免截取到其他窗口的内容
        import -window $THE_WIN_ID -frame screenshot/$FILE_NAME.png
    fi

    # 和前面截取的文件内容进行比较, 如果没有区别, 则只保留一个文件(减少长时间"发呆"产生大量相同的截图)
    cmp -s screenshot/$FILE_NAME.png screenshot/$PRE_FILE.png
    if [ $? == 0 ] ; then
        echo -ne " [X]$PRE_FILE  \b"
        rm -f screenshot/$PRE_FILE.png
    fi

    PRE_FILE=$FILE_NAME

    sleep 1
done

