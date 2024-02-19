#!/usr/bin/env sh

ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh


# define functions

function print_error
{
cat << "EOF"
    ./networkcontrol.sh <action>
    ...valid actions are...
        p -- <p>ower on/off
        d -- <d>iscoverable on/off
EOF
}

function notify_p_state
{
    ico="${icodir}/hyprdots.svg"
    notify-send -a "Wi-Fi" -i ${ico} -r 91190 -t 800 "Powered" "$state"
}

function set_p_state
{
    p_state=`nmcli radio wifi`
    if [ "$p_state" == "enabled" ] ; then
        nmcli radio wifi off
        state="Off"
    elif [ "$p_state" == "disabled" ] ; then
        nmcli radio wifi on
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

