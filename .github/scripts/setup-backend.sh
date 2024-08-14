#!/bin/bash

LOCAL_FOLDER=$(echo "$1" | xargs)
REGION=$(echo "$2" | xargs)
REMOTE_STATE_BUCKET=$(echo "$3" | xargs)
SUB_PROJECT_NAME=$(echo "$4" | xargs)

cat <<EOF > "./${LOCAL_FOLDER}/backend.tfvars"
region = "${REGION}"
bucket = "${REMOTE_STATE_BUCKET}"
key    = "${SUB_PROJECT_NAME}/terraform.tfstate"
EOF

cat "./${LOCAL_FOLDER}/backend.tfvars"
