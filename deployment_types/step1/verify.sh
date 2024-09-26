#!/bin/bash

deployment=$(kubectl get deployment nginx -o jsonpath='{.metadata.name}' 2>/dev/null)
if [ "$deployment" != "nginx" ]; then
  echo "Deployment 'nginx' does not exist."
  exit 1
fi

image=$(kubectl get deployment nginx -o jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$image" != "nginx:1.18.0" ]; then
  echo "Deployment 'nginx' does not use the image 'nginx:1.18.0'."
  exit 1
fi

replicas=$(kubectl get deployment nginx -o jsonpath='{.spec.replicas}')
if [ "$replicas" -ne 4 ]; then
  echo "Deployment 'nginx' does not have 4 replicas."
  exit 1
fi

strategy=$(kubectl get deployment nginx -o jsonpath='{.spec.strategy.type}')
if [ "$strategy" != "Recreate" ]; then
  echo "Deployment 'nginx' does not use the 'Recreate' strategy."
  exit 1
fi

port=$(kubectl get deployment nginx -o jsonpath='{.spec.template.spec.containers[0].ports[0].containerPort}')
if [ "$port" -ne 80 ]; then
  echo "Deployment 'nginx' does not expose port 80."
  exit 1
fi

echo "Deployment 'nginx' verification passed."