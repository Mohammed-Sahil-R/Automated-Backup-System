#!/bin/bash
# =============================================================
# setup_cron.sh — Register backup.sh as a daily cron job
# Author : Mohammed Sahil R
# =============================================================

SCRIPT_PATH="$(realpath "$(dirname "$0")/backup.sh")"
CRON_SCHEDULE="0 2 * * *"   # Daily at 2:00 AM

# Check backup.sh exists and is executable
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "ERROR: backup.sh not found at $SCRIPT_PATH"
    exit 1
fi

chmod +x "$SCRIPT_PATH"

# Add to crontab if not already present
CRON_ENTRY="$CRON_SCHEDULE $SCRIPT_PATH"
( crontab -l 2>/dev/null | grep -qF "$SCRIPT_PATH" ) && {
    echo "Cron job already exists. No changes made."
    exit 0
}

( crontab -l 2>/dev/null; echo "$CRON_ENTRY" ) | crontab -
echo "Cron job registered successfully:"
echo "  $CRON_ENTRY"
echo ""
echo "Backups will run automatically every day at 2:00 AM."
echo "To verify: run  crontab -l"
