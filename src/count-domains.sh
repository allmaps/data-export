#!/usr/bin/env bash

jq --slurp 'include "./src/counter"; include "./src/parse-url"; counter(.[] | .resource.id | parseUrl | .domain)'
