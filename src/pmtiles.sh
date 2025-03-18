#!/usr/bin/env bash

cat ./data/maps.geojson | ./src/flatten-geojson.sh > ./data/maps-flattened.geojson

# TODO: split by scale!
# TODO: only upload if succeeded

tippecanoe -f -z8 --simplify-only-low-zooms --full-detail=24 --visvalingam \
  --drop-densest-as-needed \
  --projection=EPSG:4326 \
  -y "id" -y "scale" -y "area" -y "modified" \
  -y "resourceId" -y "resourceType" -y "resourceWidth" -y "resourceHeight" \
  -y "imageServiceDomain" \
  -o ./data/maps.pmtiles -l masks ./data/maps-flattened.geojson

rm ./data/maps-flattened.geojson
