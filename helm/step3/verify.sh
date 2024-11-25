#!/bin/bash

# Check if the WordPress chart is installed with the name my-wordpress
if helm list | grep -q 'my-wordpress'; then
  echo "The WordPress chart is installed with the name my-wordpress."
else
  echo "The WordPress chart is not installed with the name my-wordpress."
  exit 1
fi