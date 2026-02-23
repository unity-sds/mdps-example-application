#!/bin/bash

set -e 

BASE_DIR=$(realpath $(dirname $0)/../..)

cd $BASE_DIR

# Use an alternative state dir to not conflict with build_app.sh
state_dir=".ghcr_app_gen"

# Build from Github so the label applied to the image matches the source
build_ogc_app --state_directory $state_dir init git@github.com:unity-sds/mdps-example-application.git .ghcr_app_gen/repo

build_ogc_app --state_directory $state_dir build_docker
build_ogc_app --state_directory $state_dir push_ghcr
build_ogc_app --state_directory $state_dir build_cwl