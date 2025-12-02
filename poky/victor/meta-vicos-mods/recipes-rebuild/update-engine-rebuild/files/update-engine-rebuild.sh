#!/usr/bin/env bash

# A very jank auto update solution for 1.6-rebuild

logger -t rebuild-auto-updater "Starting 1.6-rebuild auto update service"


if [ -f /run/rebuild-updated ]; then
    echo "An update is already pending, waiting until nightly reboot"
    logger -t rebuild-auto-updater "An update is already pending, waiting until nightly reboot"
    exit 0
else
    echo "No updates pending, continuing..."
    logger -t rebuild-auto-updater "No updates pending, continuing..."
fi

if [ -f /data/data/user-do-not-auto-update ]; then
    echo "Auto update disabled by user, falling out"
    logger -t rebuild-auto-updater "Auto update disabled by user, falling out"
    exit 0
else
    echo "Auto updates are not disabled, continuing with updating"
    logger -t rebuild-auto-updater "Auto updates are not disabled, continuing with updating"
fi

# Auto updates are enabled, clear to set some variables
# In alphabetical order too!
BUILDINF="$(cat /build.prop)"
CMDLINE="$(cat /proc/cmdline)"
CURRENT_VERSION=$(getprop ro.anki.version)
DEV_BUILD_ID=d
DEV_CLOUDLESS_BUILD_ID=dcldless
EXTENSION=$(getprop ro.build.id)
OSKR_BUILD_ID=oskr
OSKR_CLOUDLESS_BUILD_ID=oskrcldless
PROD_CLOUDLESS_BUILD_ID=cldless
REBUILD_URL="http://anki2.ca/otas/1.6-rebuild"

if [ -f /etc/rebuild-indev ]; then
    echo "Indev ota detected, downloading from indev stack"
    logger -t rebuild-auto-updater "Indev ota detected, downloading from indev stack"
    TARGET_VERSION=$(curl $REBUILD_URL/indev/latest)
    FORCE_INSTALL=$(curl $REBUILD_URL/indev/force_install)
    INDEV=1
elif [ -f /etc/rebuild-release ]; then
    echo "Release ota detected, downloading from Release stack"
    logger -t rebuild-auto-updater "Release ota detected, downloading from Release stack"
    TARGET_VERSION=$(curl $REBUILD_URL/release/latest)
    FORCE_INSTALL=$(curl $REBUILD_URL/indev/force_install)
    RELEASE=1
else
    echo "Not indev or release, exiting"
    logger -t rebuild-auto-updater "Not indev or release, exiting"
    exit 1
fi

echo "Checking active slot"
logger -t rebuild-auto-updater "Checking active slot"
if [[ ${CMDLINE} == *"androidboot.slot_suffix=_b"* ]]; then
	echo "Current slot is b, update will install to a."
    INSTALL_SLOT=a
    logger -t rebuild-auto-updater "Current slot is b, update will install to a."
else
	echo "Current slot is a, update will install to b."
    INSTALL_SLOT=b
    logger -t rebuild-auto-updater "Current slot is a, update will install to b."
fi


echo "Current firmware version: $CURRENT_VERSION"
logger -t rebuild-auto-updater "Current firmware version: $CURRENT_VERSION"

echo "Target update version is $TARGET_VERSION"
logger -t rebuild-auto-updater "Target update version is $TARGET_VERSION"

if [[ ${EXTENSION} == $CURRENT_VERSION$DEV_BUILD_ID ]]; then
	echo "Build type is dev"
    logger -t rebuild-auto-updater "Build type is dev"
    CURRENT_BUILD_ID=d
    DEV=1
elif [[ ${EXTENSION} == $CURRENT_VERSION$DEV_CLOUDLESS_BUILD_ID ]]; then
	echo "Build type is dev Cloudless"
    logger -t rebuild-auto-updater "Build type is dev Cloudless"
    CURRENT_BUILD_ID=dcldless
    DEV=1
elif [[ ${EXTENSION} == $CURRENT_VERSION$OSKR_BUILD_ID ]]; then
	echo "Build type is OSKR"
    logger -t rebuild-auto-updater "Build type is OSKR"
    CURRENT_BUILD_ID=oskr
    OSKR=1
elif [[ ${EXTENSION} == $CURRENT_VERSION$OSKR_CLOUDLESS_BUILD_ID ]]; then
	echo "Build type is OSKR Cloudless"
    logger -t rebuild-auto-updater "Build type is OSKR Cloudless"
    CURRENT_BUILD_ID=oskrcldless
    OSKR=1
elif [[ ${EXTENSION} == $CURRENT_VERSION$PROD_CLOUDLESS_BUILD_ID ]]; then
	echo "Build type is PROD Cloudless"
    logger -t rebuild-auto-updater "Build type is PROD Cloudless"
    CURRENT_BUILD_ID=cldless
    PROD=1
else
	echo "Build type is production"
    logger -t rebuild-auto-updater "Build type is production"
    CURRENT_BUILD_ID=
    PROD=1
fi

if [ -f /data/data/user-do-not-auto-update ]; then
    if [[ $FORCE_INSTALL == 1 ]]; then
        echo "Force install set to 1 on server, ignoring user auto update settings"
        logger -t rebuild-auto-updater "Force install set to 1 on server, ignoring user auto update settings"
    else
        echo "Auto update disabled by user, falling out"
        logger -t rebuild-auto-updater "Auto update disabled by user, falling out"
        exit 0
    fi
else
    echo "Auto updates are not disabled, continuing with updating"
    logger -t rebuild-auto-updater "Auto updates are not disabled, continuing with updating"
fi

if [[ $CURRENT_VERSION == $TARGET_VERSION ]]; then
    if [[ $FORCE_INSTALL == 1 ]]; then
        echo "Force install set to 1 on server, must be a very important reason why"
        logger -t rebuild-auto-updater "Force install set to 1 on server, must be a very important reason why"
    else
        echo "Rebuild up to date, exiting"
        logger -t rebuild-auto-updater "Rebuild up to date, exiting"
        exit 0
    fi
fi

if [ -f /anki-devtools ]; then
    if [[ $FORCE_INSTALL == 1 ]]; then
        echo "Force install set to 1 on server, skipping devtool check"
        logger -t rebuild-auto-updater "Force install set to 1 on server, skipping devtool check"
    else
        echo "Build has been deployed to, not auto updating"
        logger -t rebuild-auto-updater "Build has been deployed to, not auto updating"
        exit 0
    fi
else
    echo "Build is stock, auto updates allowed"
    logger -t rebuild-auto-updater "Build is stock, auto updates allowed"
fi

if [[ $CURRENT_VERSION >= $TARGET_VERSION ]]; then
    echo "Downgrading versions, there was likely a bug in the latest version."
    logger -t rebuild-auto-updater "Downgrading versions, there was likely a bug in the latest version."
fi

echo "Installing ota update to system slot $INSTALL_SLOT"
logger -t rebuild-auto-updater "Installing ota update to system slot $INSTALL_SLOT"
if [[ ${DEV} = 1 ]]; then
    if [[ ${INDEV} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${DEV_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/indev/devcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        else
            FINAL_REBUILD_URL=$REBUILD_URL/indev/dev/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        fi
    elif [[ ${RELEASE} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${DEV_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/release/devcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        else
            FINAL_REBUILD_URL=$REBUILD_URL/release/dev/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        fi
    fi
elif [[ ${OSKR} = 1 ]]; then
    if [[ ${INDEV} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${OSKR_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/indev/oskrcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        else
            FINAL_REBUILD_URL=$REBUILD_URL/indev/oskr/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        fi
    elif [[ ${RELEASE} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${OSKR_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/release/oskrcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        else
            FINAL_REBUILD_URL=$REBUILD_URL/release/oskr/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        fi
    fi
elif [[ ${PROD} = 1 ]]; then
    if [[ ${INDEV} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${PROD_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/indev/prodcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        else
            FINAL_REBUILD_URL=$REBUILD_URL/indev/prod/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        fi
    elif [[ ${RELEASE} = 1 ]]; then
        if [[ ${CURRENT_BUILD_ID} = ${PROD_CLOUDLESS_BUILD_ID} ]]; then
            FINAL_REBUILD_URL=$REBUILD_URL/release/prodcloudless/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        else
            FINAL_REBUILD_URL=$REBUILD_URL/release/prod/vicos-$TARGET_VERSION$CURRENT_BUILD_ID.ota
            echo "Update URL $FINAL_REBUILD_URL"
            logger -t rebuild-auto-updater "Update URL $FINAL_REBUILD_URL"
            /sbin/rebuild-update-os $FINAL_REBUILD_URL
        fi
    fi
fi

sync
echo
echo "Update Done"
logger -t rebuild-auto-updater "Update Done"
exit 0