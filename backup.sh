#!/bin/bash
# =============================================================
# backup.sh — Automated Linux Backup System
# Author : Mohammed Sahil R
# GitHub : https://github.com/Mohammed-Sahil-R/Automated-Backup-System
# =============================================================

# ─────────────────────────────────────────────
# CONFIGURATION — edit these paths as needed
# ─────────────────────────────────────────────
SOURCE_DIR="/home/$USER/documents"          # Directory to back up
BACKUP_DIR="/home/$USER/backups"            # Where backups are stored
MAX_BACKUPS=7                               # Number of recent backups to keep
LOG_FILE="$BACKUP_DIR/backup.log"          # Log file path
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")     # Timestamp for archive name
ARCHIVE_NAME="backup_$TIMESTAMP.tar.gz"    # Archive filename

# ─────────────────────────────────────────────
# HELPER — log a message with timestamp
# ─────────────────────────────────────────────
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# ─────────────────────────────────────────────
# STEP 1 — Ensure backup directory exists
# ─────────────────────────────────────────────
mkdir -p "$BACKUP_DIR"

log "========================================"
log "Backup started."
log "Source      : $SOURCE_DIR"
log "Destination : $BACKUP_DIR"

# ─────────────────────────────────────────────
# STEP 2 — Validate source directory
# ─────────────────────────────────────────────
if [ ! -d "$SOURCE_DIR" ]; then
    log "ERROR: Source directory '$SOURCE_DIR' does not exist. Aborting."
    exit 1
fi

# ─────────────────────────────────────────────
# STEP 3 — Create compressed archive
# ─────────────────────────────────────────────
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")" 2>>"$LOG_FILE"

if [ $? -eq 0 ]; then
    SIZE=$(du -sh "$BACKUP_DIR/$ARCHIVE_NAME" | cut -f1)
    log "Archive created: $ARCHIVE_NAME ($SIZE)"
else
    log "ERROR: Backup failed. Check permissions or available disk space."
    exit 1
fi

# ─────────────────────────────────────────────
# STEP 4 — Remove oldest backups (keep MAX_BACKUPS)
# ─────────────────────────────────────────────
BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
    EXTRAS=$((BACKUP_COUNT - MAX_BACKUPS))
    log "Retention policy: keeping last $MAX_BACKUPS backups. Removing $EXTRAS old backup(s)."

    ls -1t "$BACKUP_DIR"/backup_*.tar.gz | tail -n "$EXTRAS" | while read -r OLD_BACKUP; do
        rm -f "$OLD_BACKUP"
        log "Removed: $(basename "$OLD_BACKUP")"
    done
fi

# ─────────────────────────────────────────────
# STEP 5 — Summary
# ─────────────────────────────────────────────
REMAINING=$(ls -1 "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | wc -l)
log "Backup completed successfully. Total backups stored: $REMAINING"
log "========================================"

exit 0
