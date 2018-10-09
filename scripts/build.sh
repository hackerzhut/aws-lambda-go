#!/bin/sh
dep ensure
rm -rf dist/
cd src/handlers/

for f in *.go; do
  filename="${f%.go}"
  if CGO_ENABLED=0 GOOS=linux go build -v -a -installsuffix cgo -o "../../dist/$filename" ${f}; then
    chmod +x "../../dist/$filename"
    echo "✓ Compiled $filename"
  else
    echo "✕ Failed to compile $filename!"
    exit 1
  fi
done
echo "✓ Done"