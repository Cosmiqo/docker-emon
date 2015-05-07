#!/bin/bash 

EMONBASE_DIR="emonbase"
EMONCMS_DIR="emoncms"
EMONDATA_DIR="emondata"

# Build the base image
cd "$EMONBASE_DIR"
docker build -t cosmiqo/emonbase .
cd ..

# Build the data image
cd "$EMONDATA_DIR"
docker build -t cosmiqo/emondata .
cd ..

# Build the emoncms image
cd "$EMONCMS_DIR"
docker build -t cosmiqo/emoncms .
cd ..

docker pull busybox
