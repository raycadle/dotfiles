#!/usr/bin/env sh

ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh


# define functions

function print_error
{
cat << "EOF"
    ./bluetoothcontrol.sh <action>
    ...valid actions are...
        p -- <p>ower on/off
        d -- <d>iscoverable on/off
EOF
}

function notify_p_state
{
    ico="${icodir}/hyprdots.svg"
    notify-send -a "Bluetooth" -i ${ico} -r 91190 -t 800 "Powered" "$state"
}

function set_p_state
{
    p_state=`bluetoothctl show | grep "Powered:" | awk '{print $2}'`
    if [ "$p_state" == "yes" ] ; then
        bluetoothctl power off
        state="Off"
    elif [ "$p_state" == "no" ] ; then
        bluetoothctl power on
        state="On"
    fi
}

icodir="~/.config/swaync/icons"

# set device action
case $1 in
    p) set_p_state
        notify_p_state ;;
    *) print_error ;;
esac

