#!/usr/bin/env bash

rclone --config="./config/rclone.conf" copy ./data r2:allmaps-files
