#!/bin/bash

# BSRN Data Download Script
# Downloads BSRN (Baseline Surface Radiation Network) data from the FTP server

echo "Starting BSRN data download..."
echo "================================"

# Create data directory if it doesn't exist
mkdir -p data

# Try downloading with different methods
echo "Attempting download from ftp.bsrn.awi.de..."

# Method 1: Try with anonymous login (no password)
echo "Method 1: Anonymous login..."
wget --user=anonymous --password='' \
     ftp://ftp.bsrn.awi.de/asp/asp0220.dat.gz \
     -O data/asp0220.dat.gz 2>&1

# If that fails, try without credentials
if [ ! -f data/asp0220.dat.gz ] || [ ! -s data/asp0220.dat.gz ]; then
    echo ""
    echo "Method 1 failed. Trying Method 2: Direct anonymous access..."
    wget ftp://ftp.bsrn.awi.de/asp/asp0220.dat.gz \
         -O data/asp0220.dat.gz 2>&1
fi

# Check if download was successful
if [ -f data/asp0220.dat.gz ] && [ -s data/asp0220.dat.gz ]; then
    echo ""
    echo "================================"
    echo "✓ Download completed successfully!"
    echo "File saved to: data/asp0220.dat.gz"
    
    # Extract the gzip file
    echo ""
    echo "Extracting gz file..."
    gunzip -v data/asp0220.dat.gz
    
    if [ $? -eq 0 ]; then
        echo "✓ Extraction completed!"
        echo "Data file ready: data/asp0220.dat"
    else
        echo "✗ Extraction failed. The gz file may be corrupted."
        exit 1
    fi
else
    echo "================================"
    echo "✗ Download failed."
    echo ""
    echo "Possible solutions:"
    echo "1. Check if the FTP server is accessible: ftp://ftp.bsrn.awi.de/asp/"
    echo "2. Try downloading manually with: curl -O ftp://ftp.bsrn.awi.de/asp/asp0220.dat.gz"
    echo "3. Check your internet connection"
    echo "4. The file path or server credentials may have changed"
    exit 1
fi

echo ""
echo "Process completed successfully!"
