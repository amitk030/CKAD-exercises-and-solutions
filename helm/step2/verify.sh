#!/bin/bash

if helm repo list | grep -q 'https://charts.bitnami.com/bitnami'; then
  echo "Bitnami repo is already added to Helm."
else
  echo "Bitnami repo is not added to Helm."
  exit 1
fi