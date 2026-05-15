#!/bin/sh
#
# Toggle enable FBInk SS on boot on/off by creating/removing the flag file.
# Also installs the upstart conf if not present.
#

FLAG_FILE="/mnt/us/ENABLE_FBINK_SS_ON_BOOT"
EXT_DIR="/mnt/us/extensions/kindle-series-manager"
UPSTART_SRC="$EXT_DIR/upstart/fbink_ss.conf"
UPSTART_DST="/etc/upstart/fbink_ss.conf"

mntroot rw

if [ -f "$FLAG_FILE" ]; then
    rm -f "$FLAG_FILE"

    if [ -f "$UPSTART_DST" ]; then
        rm -f "$UPSTART_DST"
    fi

	"$EXT_DIR/bin/fbink_ss_toggle.sh" "disable"
else
    touch "$FLAG_FILE"

    if [ -f "$UPSTART_SRC" ] && [ ! -f "$UPSTART_DST" ]; then
        cp "$UPSTART_SRC" "$UPSTART_DST"
    fi

    "$EXT_DIR/bin/fbink_ss_toggle.sh" "enable"
fi
