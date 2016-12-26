#!/bin/bash
set -x
export HOME=/root 

branch=$CI_BUILD_REF_NAME

echo $branch

if [ $branch = "development" ];
then
  cap deploy
fi