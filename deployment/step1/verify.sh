#!/bin/bash

DEPLOYMENT_NAME="nginx"
NAMESPACE="default"
IMAGE="nginx:1.18.0"
REPLICAS=2
PORT=80

check_deployment() {
    DEPLOYMENT=$(kubectl get deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE" --no-headers --ignore-not-found)
    if [ -z "$DEPLOYMENT" ]; then
        echo "Deployment '$DEPLOYMENT_NAME' not found in namespace '$NAMESPACE'"
        exit 1
    else
        echo "Deployment '$DEPLOYMENT_NAME' exists."
    fi

    IMAGE_USED=$(kubectl get deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE" -o=jsonpath='{.spec.template.spec.containers[0].image}')
    if [ "$IMAGE_USED" != "$IMAGE" ]; then
        echo "Deployment image mismatch: expected '$IMAGE', found '$IMAGE_USED'"
        exit 1
    else
        echo "Deployment image matches: $IMAGE"
    fi

    CURRENT_REPLICAS=$(kubectl get deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE" -o=jsonpath='{.spec.replicas}')
    if [ "$CURRENT_REPLICAS" != "$REPLICAS" ]; then
        echo "Replica count mismatch: expected '$REPLICAS', found '$CURRENT_REPLICAS'"
        exit 1
    else
        echo "Replica count matches: $REPLICAS"
    fi

    CONTAINER_PORT=$(kubectl get deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE" -o=jsonpath='{.spec.template.spec.containers[0].ports[0].containerPort}')
    if [ "$CONTAINER_PORT" != "$PORT" ]; then
        echo "Port mismatch: expected port '$PORT', found port '$CONTAINER_PORT'"
        exit 1
    else
        echo "Port matches: $PORT"
    fi

    echo "All checks passed successfully."
}

check_deployment
