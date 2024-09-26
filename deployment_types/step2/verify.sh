#!/bin/bash

deployment=$(kubectl get deployment nginx -o jsonpath='{.metadata.name}' 2>/dev/null)
if [ "$deployment" != "nginx" ]; then
  echo "Deployment 'nginx' does not exist."
  exit 1
fi

strategy=$(kubectl get deployment nginx -o jsonpath='{.spec.strategy.type}')
if [ "$strategy" != "RollingUpdate" ]; then
  echo "Deployment 'nginx' does not use the 'RollingUpdate' strategy."
  exit 1
fi

port=$(kubectl get deployment nginx -o jsonpath='{.spec.template.spec.containers[0].ports[0].containerPort}')
if [ "$port" -ne 80 ]; then
  echo "Deployment 'nginx' does not expose port 80."
  exit 1
fi

maxSurge=$(kubectl get deployment nginx -o jsonpath='{.spec.strategy.rollingUpdate.maxSurge}')
if [ "$maxSurge" != "50%" ]; then
  echo "Deployment 'nginx' does not have maxSurge set to 50%."
  exit 1
fi

echo "Deployment 'nginx' verification passed."