#!/bin/bash

namespace=$(kubectl get namespace blue-green -o jsonpath='{.metadata.name}' 2>/dev/null)
if [ "$namespace" != "blue-green" ]; then
  echo "Namespace 'blue-green' does not exist."
  exit 1
fi

deployment=$(kubectl get deployment green -n blue-green -o jsonpath='{.metadata.name}' 2>/dev/null)
if [ "$deployment" != "green" ]; then
  echo "Deployment 'green' does not exist in namespace 'blue-green'."
  exit 1
fi

replicas=$(kubectl get deployment green -n blue-green -o jsonpath='{.spec.replicas}')
if [ "$replicas" -ne 1 ]; then
  echo "Deployment 'green' does not have 1 replica."
  exit 1
fi

image=$(kubectl get deployment green -n blue-green -o jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$image" != "nginx:1.19.8" ]; then
  echo "Deployment 'green' does not use the image 'nginx:1.19.8'."
  exit 1
fi

init_command=$(kubectl get deployment green -n blue-green -o jsonpath='{.spec.template.spec.initContainers[0].command}' | jq -r '. | join(" ")')
if [[ "$init_command" != *"echo 'This is green deployment' > /sd/index.html"* ]]; then
  echo "Init container command is incorrect."
  exit 1
fi

volume_mounts=$(kubectl get deployment green -n blue-green -o jsonpath='{.spec.template.spec.containers[0].volumeMounts[0].mountPath}')
if [ "$volume_mounts" != "/usr/share/nginx/html" ]; then
  echo "Volume mount path is incorrect."
  exit 1
fi

service=$(kubectl get svc nginx-svc -n blue-green -o jsonpath='{.metadata.name}' 2>/dev/null)
if [ "$service" != "nginx-svc" ]; then
  echo "Service 'nginx-svc' does not exist in namespace 'blue-green'."
  exit 1
fi

service_type=$(kubectl get svc nginx-svc -n blue-green -o jsonpath='{.spec.type}')
if [ "$service_type" != "ClusterIP" ]; then
  echo "Service 'nginx-svc' is not of type 'ClusterIP'."
  exit 1
fi

service_port=$(kubectl get svc nginx-svc -n blue-green -o jsonpath='{.spec.ports[0].port}')
if [ "$service_port" -ne 80 ]; then
  echo "Service 'nginx-svc' does not expose port 80."
  exit 1
fi

service_selector=$(kubectl get svc nginx-svc -n blue-green -o jsonpath='{.spec.selector.mark}')
if [ "$service_selector" != "green" ]; then
  echo "Service 'nginx-svc' does not have the correct selector 'mark=green'."
  exit 1
fi

deployment_blue=$(kubectl get deployment blue -n blue-green -o jsonpath='{.metadata.name}' 2>/dev/null)
if [ "$deployment_blue" == "blue" ]; then
  echo "Deployment 'blue' exists in namespace 'blue-green'."
  exit 1
fi

echo "All checks passed."