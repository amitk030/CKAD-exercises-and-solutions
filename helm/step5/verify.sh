#!/bin/bash

chart_status=$(helm list -f my-wordpress | grep my-wordpress)

if [ -z "$chart_status" ]; then
  echo "The wordpress chart is uninstalled."
  exit 0
else
  echo "The wordpress chart is still installed."
  exit 1
fi