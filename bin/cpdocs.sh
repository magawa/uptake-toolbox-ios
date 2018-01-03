#!/bin/bash

if which aws > /dev/null; then
  echo "AWS CLI is installed."
else
  echo "Installing AWS CLI..."
  brew install awscli
fi

DIRNAME=${PWD##*/}
S3PATH=${BITRISE_APP_TITLE:-$DIRNAME}
aws s3 cp --recursive docs/ s3://uptake-cat-rental-app/toolkit-documentation/${S3PATH}/
