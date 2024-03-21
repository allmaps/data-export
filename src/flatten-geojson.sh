#!/usr/bin/env bash

jq --stream 'include "./src/map-id"; include "./src/parse-url";
{
  type: "FeatureCollection",
  features: [.features[] | {
    type: "Feature",
    properties: {
      mapId: .properties._allmaps.id | mapId,
      id: .properties._allmaps.id,
      scale: .properties._allmaps.scale,
      area: .properties._allmaps.area,
      resourceId: .properties.resource.id,
      resourceType: .properties.resource.type,
      resourceWidth: .properties.resource.width,
      resourceHeight: .properties.resource.height,
      imageServiceDomain: .properties.resource.id | parseUrl | .domain
    },
    geometry: .geometry}
  ]
}'
