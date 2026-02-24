#!/bin/bash

set -e 

BASE_DIR=$(realpath $(dirname $0)/../..)

cd $BASE_DIR

build_ogc_app init .

build_ogc_app build_docker -n unity-sds -r mdps-example-application
build_ogc_app build_cwl