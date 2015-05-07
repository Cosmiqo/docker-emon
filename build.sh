#!/bin/bash 

EMONBASE_DIR="images/emonbase"
EMONCMS_DIR="images/emoncms"
EMONDATA_DIR="images/emondata"

# Build the base image
cd "$EMONBASE_DIR"
docker build -t cosmiqo/emonbase .
cd ../..

# Build the data image
cd "$EMONDATA_DIR"
docker build -t cosmiqo/emondata .
cd ../..

# Build the emoncms image
cd "$EMONCMS_DIR"
docker build -t cosmiqo/emoncms .
cd ../..
