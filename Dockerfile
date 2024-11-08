# Gunakan Python 3.9 sebagai base image
FROM python:3.9-slim

# Install PM2 dan dependensi yang diperlukan
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    && npm install pm2 -g \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements.txt dan install dependensi Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy seluruh kode program
COPY run.py .
COPY entrypoint.sh .

# Buat file proxies.txt kosong
RUN touch proxies.txt

# Berikan permission eksekusi untuk entrypoint.sh
RUN chmod +x entrypoint.sh

# Set entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"] 