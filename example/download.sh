#!/bin/bash

if command -v unzip >/dev/null 2>&1; then
    echo "unzip already installed"
else
    apt update && apt install -y unzip
fi

if command -v rclone >/dev/null 2>&1; then
    echo "rclone already installed: $(rclone version | head -1)"
else
    curl https://rclone.org/install.sh | bash
fi

echo "Downloading ..."
rclone copy r2:joshtalks-ai/ICASP/english/processed_data_10hr/ \
 /workspace/processed_data \
 -P \
 --transfers 32 \
 --checkers 32 \
 --stats 5s \
 --retries 3 \
 --low-level-retries 10 \
 --retries-sleep 2s \
 --s3-chunk-size 100M \
 --s3-upload-concurrency 16 \
 --checksum \
 --fast-list
