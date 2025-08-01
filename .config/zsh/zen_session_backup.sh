#!/bin/bash

sleep 4

ZEN_PROFILE_DIR="/home/prdx/.var/app/app.zen_browser.zen/.zen/gr32kkec.Default (release)"

FILES_TO_BACKUP=(
    "sessionstore.jsonlz4"
    "sessionstore-backups/"
    "places.sqlite"
    "places.sqlite-wal"
    "prefs.js"
    "containers.json"
)


if pgrep --exact zen > /dev/null; then
    notify-send "Zen Backup Skipped" "Zen backup skipped cause zen is currently running!"
    exit 1
fi


TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
DESTINATION_DIR="/home/prdx/Documents/backups/zen/zen_backup_$TIMESTAMP"

mkdir -p "$DESTINATION_DIR"


for item in "${FILES_TO_BACKUP[@]}"; do
    if ! cp -r "$ZEN_PROFILE_DIR/$item" "$DESTINATION_DIR/"; then
        notify-send "Zen Backup Failed" "Failed to copy $item"
        exit 1
    fi
done

echo "Backup created at: $DESTINATION_DIR"
