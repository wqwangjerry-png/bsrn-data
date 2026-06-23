#!/bin/bash

# BSRN Data Download Script
# Downloads BSRN (Baseline Surface Radiation Network) data from the FTP server

echo "Starting BSRN data download..."
echo "================================"

# Create data directory if it doesn't exist
mkdir -p data

# Method 1: Try with the provided email as password (standard FTP anonymous login)
echo "Attempting download from ftp.bsrn.awi.de..."
echo "Method 1: Using email as password..."
wget --user=anonymous --password='wenqi.wang@cityu.edu.hk' \
     ftp://ftp.bsrn.awi.de/asp/asp0220.dat.gz \
     -O data/asp0220.dat.gz 2>/dev/null

if [ -f data/asp0220.dat.gz ] && [ -s data/asp0220.dat.gz ]; then
    echo "✓ Download successful!"
else
    # Method 2: Try with curl instead
    echo "Method 1 failed. Trying Method 2 with curl..."
    curl -u anonymous:wenqi.wang@cityu.edu.hk \
         ftp://ftp.bsrn.awi.de/asp/asp0220.dat.gz \
         -o data/asp0220.dat.gz 2>/dev/null
fi

# Check if download was successful
if [ -f data/asp0220.dat.gz ] && [ -s data/asp0220.dat.gz ]; then
    echo ""
    echo "================================"
    echo "✓ Download completed successfully!"
    echo "File size: $(du -h data/asp0220.dat.gz | cut -f1)"
    echo "File saved to: data/asp0220.dat.gz"
    
    # Extract the gzip file
    echo ""
    echo "Extracting gz file..."
    gunzip -v data/asp0220.dat.gz
    
    if [ $? -eq 0 ]; then
        echo "✓ Extraction completed!"
        echo "Data file ready: data/asp0220.dat"
        echo "File size: $(du -h data/asp0220.dat | cut -f1)"
    else
        echo "✗ Extraction failed. The gz file may be corrupted."
        exit 1
    fi
else
    echo ""
    echo "================================"
    echo "✗ Download failed. FTP server rejected authentication."
    echo ""
    echo "Troubleshooting steps:"
    echo "1. Check if the FTP server is online: ftp ftp.bsrn.awi.de"
    echo "2. Verify the file path exists: /asp/asp0220.dat.gz"
    echo "3. Contact BSRN data center for access credentials"
    echo "4. Check if your IP is whitelisted on the FTP server"
    exit 1
fi

echo ""
echo "Process completed successfully!"
