#!/bin/bash

# Cek apakah token tersedia
if [ -z "$token" ]; then
    echo "Error: Token tidak ditemukan. Jalankan container dengan -e token=<your_token>"
    exit 1
fi

# Cek apakah file proxies.txt ada dan tidak kosong
if [ ! -f "/app/proxies.txt" ]; then
    echo "Error: proxies.txt tidak ditemukan. Mount volume dengan -v ./proxies.txt:/app/proxies.txt"
    exit 1
fi

if [ ! -s "/app/proxies.txt" ]; then
    echo "Error: proxies.txt kosong. Harap isi dengan daftar proxy"
    exit 1
fi

echo "Starting Nodepay Bot..."
echo "Token tersedia: Ya"
echo "Proxies file tersedia: Ya"

# Jalankan program dengan PM2 dan redirect output ke file log
pm2 start --name nodepay-bot "python3 /app/run.py" --no-daemon --time --log /app/nodepay.log

pm2 logs