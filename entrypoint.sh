#!/bin/bash

# Cek apakah token tersedia
if [ -z "$token" ]; then
    echo "Error: Token tidak ditemukan. Jalankan container dengan -e token=<your_token>"
    exit 1
fi

# Cek apakah file proxies.txt ada
if [ ! -f "/app/proxies.txt" ]; then
    echo "Error: proxies.txt tidak ditemukan. Mount volume dengan -v ./proxies.txt:/app/proxies.txt"
    exit 1
fi

# Jalankan program dengan PM2
pm2 start --name nodepay-bot "python3 /app/run.py" --no-daemon

pm2 logs