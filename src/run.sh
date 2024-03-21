#!/usr/bin/env bash

# =============================================================================
# GeoJSON & PMTiles
# =============================================================================

wget "https://annotations.allmaps.org/maps.geojson?key=$ALLMAPS_API_KEY&limit=-1" \
  -O ./data/maps.geojson

cat ./data/maps.geojson | ./src/flatten-geojson.sh > ./data/maps-flattened.geojson

tippecanoe -f -zg --projection=EPSG:4326 --drop-densest-as-needed \
  -y "id" -y "scale" -y "area" \
  -y "resourceId" -y "resourceType" -y "resourceWidth" -y "resourceHeight" \
  -y "imageServiceDomain" \
  -o ./data/maps.pmtiles -l masks ./data/maps-flattened.geojson

rm ./data/maps-flattened.geojson

# =============================================================================
# JSON & NDJSON
# =============================================================================

# wget "https://api.allmaps.org/maps?key=$ALLMAPS_API_KEY&limit=-1" \
#   -O ./data/maps.json

# cat ./data/maps.json | jq -c '.[]' > ./data/maps.ndjson

# =============================================================================
# Upload to R2 using rclone
# =============================================================================

./src/upload.sh
