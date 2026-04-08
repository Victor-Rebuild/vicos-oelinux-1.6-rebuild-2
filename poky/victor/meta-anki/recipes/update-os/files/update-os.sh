#!/usr/bin/env bash

set -e
set -u

function usage()
{
    echo "usage: update-os [-h|lkg|latest|version|url]"
    echo "-h                   This message"
    echo "lkg                  Update to Last Known Good OS (default) via full OTA"
    echo "latest               Update to latest OS via full OTA"
    echo "version              Like 1.2.1.2210 - Update to a specific version via full OTA"
    echo "delta-latest         Update to latest OS via delta OTA (may not work)"
    echo "url                  Give a full url like http://mylaptop:5555/os.ota"
    echo ""
    echo "It will take 10 seconds or so for the download to get going and"
    echo "then you should see some progress indication.  After the install"
    echo "is done, the robot will automatically reboot."
    echo ""
    exit 0
}

trap ctrl_c INT

function ctrl_c() {
    echo -e "\n\nStopping OS update and exiting..."
    systemctl -q stop update-engine
    exit 1
}

# Rebuild things... just copy pasted from my other shitty script, aaaaa
# Build ids
DEV_BUILD_ID=d
DEV_CLOUDLESS_BUILD_ID=dcldless
OSKR_BUILD_ID=oskr
OSKR_CLOUDLESS_BUILD_ID=oskrcldless
PROD_BUILD_ID=
PROD_CLOUDLESS_BUILD_ID=cldless

# Essential things for this to work
BUILDINF="$(cat /build.prop)"
CURRENT_VERSION=$(getprop ro.anki.version)
REBUILD_URL="http://http.anki2.ca/otas/1.6-rebuild"
INDEV_OR_RELEASE="$(cat /etc/rebuild-dev-or-indev)"

if [ ${INDEV_OR_RELEASE} == indev ]; then
    TARGET_VERSION=$(curl -s -s $REBUILD_URL/indev/latest)
    INDEV=1
elif [ ${INDEV_OR_RELEASE} == release ]; then
    TARGET_VERSION=$(curl -s $REBUILD_URL/release/latest)
    RELEASE=1
elif [ ${INDEV_OR_RELEASE} == internal ]; then
    # put em on indev
    TARGET_VERSION=$(curl -s -s $REBUILD_URL/indev/latest)
    INDEV=1
else
    # here too
    TARGET_VERSION=$(curl -s -s $REBUILD_URL/indev/latest)
    INDEV=1
fi

if [[ ${CURRENT_VERSION} == *$DEV_BUILD_ID ]]; then
    CURRENT_BUILD_ID=d
    DEV=1
elif [[ ${CURRENT_VERSION} == *$DEV_CLOUDLESS_BUILD_ID ]]; then
    CURRENT_BUILD_ID=dcldless
    DEV=1
elif [[ ${CURRENT_VERSION} == *$OSKR_BUILD_ID ]]; then
    CURRENT_BUILD_ID=oskr
    OSKR=1
elif [[ ${CURRENT_VERSION} == *$OSKR_CLOUDLESS_BUILD_ID ]]; then
    CURRENT_BUILD_ID=oskrcldless
    OSKR=1
elif [[ ${CURRENT_VERSION} == *$PROD_CLOUDLESS_BUILD_ID ]]; then
    CURRENT_BUILD_ID=cldless
    PROD=1
else
    CURRENT_BUILD_ID=
    PROD=1
fi

if [[ ${DEV} = 1 ]]; then
    if [[ ${INDEV} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${DEV_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/indev/devcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        else
            FINAL_REBUILD_URL=$REBUILD_URL/indev/dev/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        fi
    elif [[ ${RELEASE} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${DEV_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/release/devcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        else
            FINAL_REBUILD_URL=$REBUILD_URL/release/dev/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        fi
    fi
elif [[ ${OSKR} = 1 ]]; then
    if [[ ${INDEV} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${OSKR_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/indev/oskrcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        else
            FINAL_REBUILD_URL=$REBUILD_URL/indev/oskr/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        fi
    elif [[ ${RELEASE} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${OSKR_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/release/oskrcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        else
            FINAL_REBUILD_URL=$REBUILD_URL/release/oskr/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        fi
    fi
elif [[ ${PROD} = 1 ]]; then
    if [[ ${INDEV} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${PROD_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/indev/prodcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        else
            FINAL_REBUILD_URL=$REBUILD_URL/indev/prod/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        fi
    elif [[ ${RELEASE} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${PROD_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/release/prodcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        else
            FINAL_REBUILD_URL=$REBUILD_URL/release/prod/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
        fi
    fi
fi

URL=$FINAL_REBUILD_URL
if [ $# -gt 0 ]; then
    case "$1" in
	-h)
	    usage
	    ;;
	latest)
	    URL=$FINAL_REBUILD_URL
	    ;;
        delta-latest)
            URL="${BASE_URL_LATEST}diff/`getprop ro.anki.version | tr -d '[a-z]'`.ota"
            ;;
	lkg)
	    ;;
	[0-9].[0-9].[0-9].[0-9]*)
	    URL="${BASE_URL}full/$1.ota"
	    ;;
	*)
	    URL=$1
	    ;;
    esac
fi


systemctl -q stop update-engine

echo "Current OS Version: `getprop ro.anki.version`"

mkdir -p /run/vic-switchboard

echo "UPDATE_ENGINE_ENABLED=True" > /run/vic-switchboard/update-engine.env
echo "UPDATE_ENGINE_MAX_SLEEP=1" >> /run/vic-switchboard/update-engine.env
echo "UPDATE_ENGINE_ALLOW_DOWNGRADE=True" >> /run/vic-switchboard/update-engine.env
echo "UPDATE_ENGINE_URL=$URL" >> /run/vic-switchboard/update-engine.env
echo "UPDATE_ENGINE_DEBUG=True" >> /run/vic-switchboard/update-engine.env

chown -R net:anki /run/vic-switchboard

systemctl restart update-engine

echo "Stopping anki-robot.target... (eyes will go dark)"
systemctl stop anki-robot.target

echo "Upping CPU+RAM frequencies..."
echo 1267200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo disabled > /sys/kernel/debug/msm_otg/bus_voting  # This prevents USB from pinning RAM to 400MHz
echo 0 > /sys/kernel/debug/msm-bus-dbg/shell-client/update_request
echo 1 > /sys/kernel/debug/msm-bus-dbg/shell-client/mas
echo 512 > /sys/kernel/debug/msm-bus-dbg/shell-client/slv
echo 0 > /sys/kernel/debug/msm-bus-dbg/shell-client/ab
echo active clk2 0 1 max 800000 > /sys/kernel/debug/rpm_send_msg/message # Max RAM freq in KHz = 400MHz
echo 1 > /sys/kernel/debug/msm-bus-dbg/shell-client/update_request

echo

echo -e "Downloading OS update from:\n$URL"

echo -e -n "\r."
DOTS=1
UPDATE_VERSION=""
while [[ ! -f /run/update-engine/done ]] ; do
    sleep 1
    if [ -z "${UPDATE_VERSION}" -a -f /run/update-engine/manifest.ini ]; then
	UPDATE_VERSION=`grep update_version /run/update-engine/manifest.ini | awk -F= '{print $NF;}'`
    fi
    if [ -f /run/update-engine/progress -a -f /run/update-engine/expected-size ] ; then
	PROGRESS=`cat /run/update-engine/progress`
	EXPECTED=`cat /run/update-engine/expected-size`
        if [ -n "$PROGRESS" -a -n "$EXPECTED" ]; then
	    PCT=$(( 100 * $PROGRESS / $EXPECTED ))
	    echo -e -n "\rUpdating to ${UPDATE_VERSION} ( ${PCT}% )"
        fi
    else
	for ((i=0;i<$DOTS;i++)); do
	    echo -n "."
	done
	DOTS=$((DOTS+1))
    fi
    if [ -f /run/update-engine/error ]; then
	ERRORMSG=`cat /run/update-engine/error`
	if [ "$ERRORMSG" != "Unclean exit" ]; then
	    echo "Error updating OS . $ERRORMSG"
	    exit 1
	fi
    fi

done

echo -e "\n\nRebooting....."

sleep 2
sync
reboot & exit
