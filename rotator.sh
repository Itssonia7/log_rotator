#!/bin/bash


LOG_FILE="production.log"
BACKUP_DIR="backups"


MAX_SIZE=100


FILE_SIZE=$(wc -c < "$LOG_FILE" | awk '{print $1}')
echo "Current log file size: ${FILE_SIZE} bytes."


if [ "$FILE_SIZE" -gt "$MAX_SIZE" ]; then
    echo "⚠️ NOTICE: Log file size exceeds limit of ${MAX_SIZE} bytes. Initiating rotation..."
    
    
    mkdir -p "$BACKUP_DIR"
    
    
    TIMESTAMP=$(date '+%Y-%m-%d_%H%M%S')
    ARCHIVE_NAME="${BACKUP_DIR}/log_backup_${TIMESTAMP}.tar.gz"
    
    
    tar -czf "$ARCHIVE_NAME" "$LOG_FILE"
    echo "✅ Success! Archive generated at: ${ARCHIVE_NAME}"
    
    
    > "$LOG_FILE"
    echo "✅ Active log truncated and reset to 0 bytes."
else
    echo "🟢 Status Normal: Log file size is within safe bounds (${FILE_SIZE}/${MAX_SIZE} bytes). No rotation required."
fi