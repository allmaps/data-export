#!/usr/bin/env bash

# If files are smaller than 32 MB, do not process and upload them
MINIMUM_DOWNLOAD_SIZE=32000000

# =============================================================================
# GeoJSON & PMTiles
# =============================================================================

wget "https://annotations.allmaps.org/maps.geojson?key=$ALLMAPS_API_KEY&limit=-1" \
  -O ./data/maps.geojson

GEOJSON_SIZE=$(wc -c < "./data/maps.geojson")

if [ $GEOJSON_SIZE -gt $MINIMUM_DOWNLOAD_SIZE ]; then
  cat ./data/maps.geojson | jq -c '.features[]' > data/maps.geojsonl

  ./src/pmtiles.sh
else
  rm ./data/maps.geojson
fi

# =============================================================================
# JSON & NDJSON
# =============================================================================

wget "https://api.allmaps.org/maps?key=$ALLMAPS_API_KEY&limit=-1" \
  -O ./data/maps.json

MAPS_SIZE=$(wc -c < "./data/maps.json")

if [ $MAPS_SIZE -gt $MINIMUM_DOWNLOAD_SIZE ]; then
  cat ./data/maps.json | jq -c '.[]' > ./data/maps.ndjson
else
  rm ./data/maps.json
fi

# =============================================================================
# Count image domains
# =============================================================================

cat ./data/maps.ndjson | ./src/count-domains.sh > ./data/domains-counted.json

# =============================================================================
# Georeference Annotations
# =============================================================================

wget "https://annotations.allmaps.org/maps?key=$ALLMAPS_API_KEY&limit=-1" \
  -O ./data/annotations.json

ANNOTATIONS_SIZE=$(wc -c < "./data/annotations.json")

if [ $ANNOTATIONS_SIZE -lt $MINIMUM_DOWNLOAD_SIZE ]; then
  rm ./data/annotations.json
fi

# =============================================================================
# Upload to R2 using rclone
# =============================================================================

./src/upload.sh
