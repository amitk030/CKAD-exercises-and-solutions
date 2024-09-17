#!/bin/bash

DEPLOYMENT_NAME="nginx"
NAMESPACE="default"
EXPECTED_IMAGE="nginx:1.19.8"
EXPECTED_REPLICAS=2
EXPECTED_PORT=80

if ! kubectl get deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE" >/dev/null 2>&1; then
    echo "Deployment '$DEPLOYMENT_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

echo "Deployment '$DEPLOYMENT_NAME' exists in namespace '$NAMESPACE'."

CONTAINER_IMAGE=$(kubectl get deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.template.spec.containers[0].image}")
if [[ "$CONTAINER_IMAGE" != "$EXPECTED_IMAGE" ]]; then
    echo "Container image does not match the expected image '$EXPECTED_IMAGE'. Found: '$CONTAINER_IMAGE'."
    exit 1
fi

echo "Container image is '$EXPECTED_IMAGE', as expected."

REPLICAS=$(kubectl get deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.replicas}")
if [[ "$REPLICAS" -ne "$EXPECTED_REPLICAS" ]]; then
    echo "Replicas do not match the expected count '$EXPECTED_REPLICAS'. Found: '$REPLICAS'."
    exit 1
fi

echo "Deployment has '$EXPECTED_REPLICAS' replicas, as expected."

CONTAINER_PORT=$(kubectl get deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.template.spec.containers[0].ports[0].containerPort}")
if [[ "$CONTAINER_PORT" -ne "$EXPECTED_PORT" ]]; then
    echo "Container port does not match the expected port '$EXPECTED_PORT'. Found: '$CONTAINER_PORT'."
    exit 1
fi

echo "Container exposes port '$EXPECTED_PORT', as expected."

echo "Deployment '$DEPLOYMENT_NAME' is correctly configured with the nginx:1.19.8 image, 2 replicas, and port 80 exposed."
exit 0
