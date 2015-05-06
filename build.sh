#!/bin/bash 

EMONBASE_DIR="emonbase"
EMONCMS_DIR="emoncms"

# Build the base image
cd "$EMONBASE_DIR"
docker build -t cosmiqo/emonbase .
cd ..

# Build the emoncms image
cd "$EMONCMS_DIR"
docker build -t cosmiqo/emoncms .
cd ..
