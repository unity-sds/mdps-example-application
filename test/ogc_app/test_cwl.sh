#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
BASE_DIR=$(realpath $(dirname $0)/../..)

WORKFLOW_FILENAME=$BASE_DIR/.unity_app_gen/cwl/process.cwl
JOB_INP_FILENAME=$SCRIPT_DIR/cwl_job_input.yml
RUN_DIR=$BASE_DIR/test/process_results

if [ ! -e $WORKFLOW_FILENAME ]; then
    echo "ERROR: Run $SCRIPT_DIR/build_app.sh first to generate CWL output"
    exit 1
fi

if [ ! -e $JOB_INP_FILENAME ]; then
    echo "ERROR: Copy ${JOB_INP_FILENAME}.template to ${JOB_INP_FILENAME} and edit to include credentials"
    exit 1
fi

mkdir -p $RUN_DIR
cd $RUN_DIR

# Detect if using Podman 
if [ ! -z "$(which podman)" ]; then
    use_podman_arg="--podman"
fi

cwltool \
    --debug --leave-tmpdir --no-read-only \
    $use_podman_arg \
    "$WORKFLOW_FILENAME" "$JOB_INP_FILENAME" \
    $* |& tee $RUN_DIR/test_modular_cwl.log