#!/bin/bash

POD_NAME="tasker"
EXPECTED_IMAGE="nginx"
EXPECTED_PORT=80
EXPECTED_READINESS_PATH="/"
EXPECTED_SCHEME="HTTP"

if ! kubectl get pod "$POD_NAME" -n "$NAMESPACE" >/dev/null 2>&1; then
    echo "Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

CONTAINER_IMAGE=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].image}")
if [[ "$CONTAINER_IMAGE" != "$EXPECTED_IMAGE" ]]; then
    echo "Container image does not match the expected image '$EXPECTED_IMAGE'. Found: '$CONTAINER_IMAGE'."
    exit 1
fi

echo "Container image is '$EXPECTED_IMAGE', as expected."

CONTAINER_PORT=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
if [[ "$CONTAINER_PORT" -ne "$EXPECTED_PORT" ]]; then
    echo "Container port does not match the expected port '$EXPECTED_PORT'. Found: '$CONTAINER_PORT'."
    exit 1
fi

echo "Container port '$EXPECTED_PORT' is exposed, as expected."

READINESS_HTTP_GET_PORT=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].readinessProbe.httpGet.port}")
READINESS_HTTP_GET_PATH=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].readinessProbe.httpGet.path}")
READINESS_HTTP_GET_SCHEME=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].readinessProbe.httpGet.scheme}")

if [[ "$READINESS_HTTP_GET_PORT" -ne "$EXPECTED_PORT" ]]; then
    echo "Readiness probe port does not match the expected port '$EXPECTED_PORT'. Found: '$READINESS_HTTP_GET_PORT'."
    exit 1
fi

if [[ "$READINESS_HTTP_GET_PATH" != "$EXPECTED_READINESS_PATH" ]]; then
    echo "Readiness probe path does not match the expected path '$EXPECTED_READINESS_PATH'. Found: '$READINESS_HTTP_GET_PATH'."
    exit 1
fi

if [[ "$READINESS_HTTP_GET_SCHEME" != "$EXPECTED_SCHEME" ]]; then
    echo "Readiness probe scheme does not match the expected scheme '$EXPECTED_SCHEME'. Found: '$READINESS_HTTP_GET_SCHEME'."
    exit 1
fi

echo "Readiness probe is correctly configured with an HTTP GET on port '$EXPECTED_PORT', path '$EXPECTED_READINESS_PATH', and scheme '$EXPECTED_SCHEME'."

echo "Pod '$POD_NAME' is correctly configured with the nginx image, exposes port 80, and has a valid readiness probe."
exit 0
