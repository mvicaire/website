#!/bin/bash

set -euo pipefail

echo "Building static site into out/ ..."

OUT_DIR="out"

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

# Required root HTML
if [ -f "index.html" ]; then
    cp index.html "$OUT_DIR"/
fi

# Cloudflare routing and headers
if [ -f "_redirects" ]; then
    cp _redirects "$OUT_DIR"/
fi
if [ -f "_headers" ]; then
    cp _headers "$OUT_DIR"/
fi

# Static assets
if [ -d "images" ]; then
    mkdir -p "$OUT_DIR/images"
    cp -r images/* "$OUT_DIR/images/"
fi

# Common icons/assets
for asset in favicon.ico icon.svg next.svg vercel.svg; do
    if [ -f "$asset" ]; then
        cp "$asset" "$OUT_DIR"/
    fi
done

echo "Static site built successfully!"
echo "Files in output directory:"
find "$OUT_DIR" -maxdepth 3 -type f -print | sed "s|^| - |"
