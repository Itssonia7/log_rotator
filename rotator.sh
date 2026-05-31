#!/bin/bash


LOG_FILE="production.log"


FILE_SIZE=$(wc -c < "$LOG_FILE" | awk '{print $1}')

echo "Current log file size: ${FILE_SIZE} bytes."