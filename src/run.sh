#!/usr/bin/env bash

# =============================================================================
# GeoJSON & PMTiles
# =============================================================================

wget "https://annotations.allmaps.org/maps.geojson?key=$ALLMAPS_API_KEY&limit=-1" \
  -O ./data/maps.geojson

cat ./data/maps.geojson | jq -c '.features[]' > data/maps.geojsonl

cat ./data/maps.geojson | ./src/flatten-geojson.sh > ./data/maps-flattened.geojson

tippecanoe -f -z8 --simplify-only-low-zooms --full-detail=24 --visvalingam \
  --drop-densest-as-needed \
  --projection=EPSG:4326 \
  -y "id" -y "scale" -y "area" -y "modified" \
  -y "resourceId" -y "resourceType" -y "resourceWidth" -y "resourceHeight" \
  -y "imageServiceDomain" \
  -o ./data/maps.pmtiles -l masks ./data/maps-flattened.geojson

rm ./data/maps-flattened.geojson

# =============================================================================
# JSON & NDJSON
# =============================================================================

wget "https://api.allmaps.org/maps?key=$ALLMAPS_API_KEY&limit=-1" \
  -O ./data/maps.json

cat ./data/maps.json | jq -c '.[]' > ./data/maps.ndjson

# =============================================================================
# Count image domains
# =============================================================================

cat ./data/maps.ndjson | ./src/count-domains.sh > ./data/domains-counted.json

# =============================================================================
# Georeference Annotations
# =============================================================================

wget "https://annotations.allmaps.org/maps?key=$ALLMAPS_API_KEY&limit=-1" \
  -O ./data/annotations.json

# =============================================================================
# Upload to R2 using rclone
# =============================================================================

./src/upload.sh
