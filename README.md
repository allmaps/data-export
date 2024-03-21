# data-export

This repository contains a Dockerfile and scripts to export Allmaps data as GeoJSON, PMTiles, JSON and NDJSON and upload to [Cloudflare R2](https://developers.cloudflare.com/r2).

Build container:

```sh
docker-compose build
```

Run container:

```sh
docker-compose up
```

Run bash in container:

```
docker run --rm -it --entrypoint bash allmaps-data-export
```

To run the containr, the following environment variables must be present. For local development, you can create a .env file that contains these variables.

- `ALLMAPS_API_KEY`
- `RCLONE_CONFIG_R2_ACCESS_KEY_ID`
- `RCLONE_CONFIG_R2_SECRET_ACCESS_KEY`
