#!/bin/bash

# BSRN Data Download Script
# Downloads BSRN (Baseline Surface Radiation Network) data from the FTP server

echo "Starting BSRN data download..."
echo "================================"

# Create data directory if it doesn't exist
mkdir -p data

# Download the data file
echo "Downloading asp0220.dat.gz from ftp.bsrn.awi.de..."
wget --user=anonymous --password='wenqi.wang@cityu.edu.hk' \
     ftp://ftp.bsrn.awi.de/asp/asp0220.dat.gz \
     -O data/asp0220.dat.gz

# Check if download was successful
if [ $? -eq 0 ]; then
    echo "================================"
    echo "✓ Download completed successfully!"
    echo "File saved to: data/asp0220.dat.gz"
    
    # Optional: Extract the gzip file
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
    echo "✗ Download failed. Please check your internet connection."
    exit 1
fi

echo ""
echo "Process completed successfully!"
