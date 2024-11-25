#!/bin/bash

current_version=$(helm list -f my-wordpress | grep my-wordpress | awk '{print $9}')

if [ "$current_version" == "9.0.0" ]; then
  echo "my-wordpress chart is upgraded to version 9.0.0"
else
  echo "my-wordpress chart is not upgraded to version 9.0.0. Current version: $current_version"
  exit 1
fi