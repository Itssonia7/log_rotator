#!/bin/bash


LOG_FILE="production.log"
BACKUP_DIR="backups"


FILE_SIZE=$(wc -c < "$LOG_FILE" | awk '{print $1}')
echo "Current log file size: ${FILE_SIZE} bytes."


mkdir -p "$BACKUP_DIR"


TIMESTAMP=$(date '+%Y-%m-%d_%H%M%S')
ARCHIVE_NAME="${BACKUP_DIR}/log_backup_${TIMESTAMP}.tar.gz"


tar -czf "$ARCHIVE_NAME" "$LOG_FILE"
echo "Success! Log file bundled and compressed into: ${ARCHIVE_NAME}"


> "$LOG_FILE"
echo "Active log truncated. Ready for new incoming records!"