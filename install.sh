#!/bin/bash

echo "🔧 Installing dependencies..."
sleep 1

# Update system
sudo apt update

# Install toilet and lolcat if not present
if ! command -v toilet &> /dev/null; then
    echo "📦 Installing toilet..."
    sudo apt install toilet -y
fi

if ! command -v lolcat &> /dev/null; then
    echo "📦 Installing lolcat..."
    sudo gem install lolcat
fi

# Install python3-pip if not present
if ! command -v pip3 &> /dev/null; then
    echo "📦 Installing pip3..."
    sudo apt install python3-pip -y
fi

# Install Python libraries (standard ones used already)
echo "📦 Ensuring Python libraries are available..."
 pip3 install --upgrade pip
 pip3 install pycryptodome cryptography

# Make the tool accessible from anywhere
if [ ! -f /usr/local/bin/kirahash ]; then
    echo "🔗 Linking main script to /usr/local/bin..."
    sudo ln -s $(pwd)/index.sh /usr/local/bin/kirahash
    sudo chmod +x index.sh
fi

# Create logs folder on Desktop only if not already created
LOG_FOLDER=~/Desktop/kirahash_logs
if [ ! -d "$LOG_FOLDER" ]; then
    echo "📁 Creating log folder on Desktop..."
    mkdir -p "$LOG_FOLDER"
else
    echo "✅ Log folder already exists: $LOG_FOLDER"
fi

echo "✅ Installation complete. Run the tool using: kirahash"
