#!/bin/bash

namespace=$(kubectl get namespace canary -o jsonpath='{.metadata.name}' 2>/dev/null)
if [ "$namespace" != "canary" ]; then
  echo "Namespace 'canary' does not exist."
  exit 1
fi

deployment_v1=$(kubectl get deployment app-v1 -n canary -o jsonpath='{.metadata.name}' 2>/dev/null)
if [ "$deployment_v1" != "app-v1" ]; then
  echo "Deployment 'app-v1' does not exist in namespace 'canary'."
  exit 1
fi

replicas_v1=$(kubectl get deployment app-v1 -n canary -o jsonpath='{.spec.replicas}')
if [ "$replicas_v1" -ne 2 ]; then
  echo "Deployment 'app-v1' does not have 2 replicas."
  exit 1
fi

image_v1=$(kubectl get deployment app-v1 -n canary -o jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$image_v1" != "nginx:1.18.0" ]; then
  echo "Deployment 'app-v1' does not use the image 'nginx:1.18.0'."
  exit 1
fi

init_command_v1=$(kubectl get deployment app-v1 -n canary -o jsonpath='{.spec.template.spec.initContainers[0].command}' | jq -r '. | join(" ")')
if [[ "$init_command_v1" != *"echo 'App Version V1' > /sd/index.html"* ]]; then
  echo "Init container command for 'app-v1' is incorrect."
  exit 1
fi

volume_mounts_v1=$(kubectl get deployment app-v1 -n canary -o jsonpath='{.spec.template.spec.containers[0].volumeMounts[0].mountPath}')
if [ "$volume_mounts_v1" != "/usr/share/nginx/html" ]; then
  echo "Volume mount path for 'app-v1' is incorrect."
  exit 1
fi

service=$(kubectl get svc app-svc -n canary -o jsonpath='{.metadata.name}' 2>/dev/null)
if [ "$service" != "app-svc" ]; then
  echo "Service 'app-svc' does not exist in namespace 'canary'."
  exit 1
fi

service_type=$(kubectl get svc app-svc -n canary -o jsonpath='{.spec.type}')
if [ "$service_type" != "ClusterIP" ]; then
  echo "Service 'app-svc' is not of type 'ClusterIP'."
  exit 1
fi

service_port=$(kubectl get svc app-svc -n canary -o jsonpath='{.spec.ports[0].port}')
if [ "$service_port" -ne 80 ]; then
  echo "Service 'app-svc' does not expose port 80."
  exit 1
fi

service_selector=$(kubectl get svc app-svc -n canary -o jsonpath='{.spec.selector.app}')
if [ "$service_selector" != "frontend" ]; then
  echo "Service 'app-svc' does not have the correct selector 'app=frontend'."
  exit 1
fi

deployment_v2=$(kubectl get deployment app-v2 -n canary -o jsonpath='{.metadata.name}' 2>/dev/null)
if [ "$deployment_v2" != "app-v2" ]; then
  echo "Deployment 'app-v2' does not exist in namespace 'canary'."
  exit 1
fi

replicas_v2=$(kubectl get deployment app-v2 -n canary -o jsonpath='{.spec.replicas}')
if [ "$replicas_v2" -ne 2 ]; then
  echo "Deployment 'app-v2' does not have 2 replicas."
  exit 1
fi

image_v2=$(kubectl get deployment app-v2 -n canary -o jsonpath='{.spec.template.spec.containers[0].image}')
if [ "$image_v2" != "nginx:1.19.8" ]; then
  echo "Deployment 'app-v2' does not use the image 'nginx:1.19.8'."
  exit 1
fi

init_command_v2=$(kubectl get deployment app-v2 -n canary -o jsonpath='{.spec.template.spec.initContainers[0].command}' | jq -r '. | join(" ")')
if [[ "$init_command_v2" != *"echo 'App Version V2' > /sd/index.html"* ]]; then
  echo "Init container command for 'app-v2' is incorrect."
  exit 1
fi

volume_mounts_v2=$(kubectl get deployment app-v2 -n canary -o jsonpath='{.spec.template.spec.containers[0].volumeMounts[0].mountPath}')
if [ "$volume_mounts_v2" != "/usr/share/nginx/html" ]; then
  echo "Volume mount path for 'app-v2' is incorrect."
  exit 1
fi

echo "All checks passed."