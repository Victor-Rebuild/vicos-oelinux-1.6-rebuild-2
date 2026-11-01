#!/usr/bin/env bash

set -e
set -u

URL=""

if [ $# -gt 0 ]; then
    case "$1" in
	*)
	    URL=$1
	    ;;
    esac
fi


systemctl -q stop update-engine

mkdir -p /run/vic-switchboard

echo "UPDATE_ENGINE_ENABLED=True" > /run/vic-switchboard/update-engine.env
echo "UPDATE_ENGINE_MAX_SLEEP=1" >> /run/vic-switchboard/update-engine.env
echo "UPDATE_ENGINE_ALLOW_DOWNGRADE=True" >> /run/vic-switchboard/update-engine.env
echo "UPDATE_ENGINE_URL=$URL" >> /run/vic-switchboard/update-engine.env
echo "UPDATE_ENGINE_DEBUG=True" >> /run/vic-switchboard/update-engine.env

chown -R net:anki /run/vic-switchboard

systemctl restart update-engine

echo 729600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo disabled > /sys/kernel/debug/msm_otg/bus_voting
echo 0 > /sys/kernel/debug/msm-bus-dbg/shell-client/update_request
echo 1 > /sys/kernel/debug/msm-bus-dbg/shell-client/mas
echo 512 > /sys/kernel/debug/msm-bus-dbg/shell-client/slv
echo 0 > /sys/kernel/debug/msm-bus-dbg/shell-client/ab
echo active clk2 0 1 max 400000 > /sys/kernel/debug/rpm_send_msg/message
echo 1 > /sys/kernel/debug/msm-bus-dbg/shell-client/update_request

while [[ ! -f /run/update-engine/done ]] ; do
    sleep 1
    if [ -f /run/update-engine/error ]; then
	ERRORMSG=`cat /run/update-engine/error`
        if [ "$ERRORMSG" != "Unclean exit" ]; then
            echo "Error updating OS . $ERRORMSG"
            exit 1
        fi
    fi

done

touch /run/rebuild-updated
sync
