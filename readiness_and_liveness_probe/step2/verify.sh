#!/bin/bash

POD_NAME="aided"
EXPECTED_IMAGE="nginx"
EXPECTED_PORT=80
EXPECTED_READINESS_PATH="/"
EXPECTED_READINESS_PORT=80
EXPECTED_HTTP_SCHEME="HTTP"

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
if [[ "$CONTAINER_PORT" != "$EXPECTED_PORT" ]]; then
    echo "Container port does not match the expected port '$EXPECTED_PORT'. Found: '$CONTAINER_PORT'."
    exit 1
fi

echo "Container port '$EXPECTED_PORT' is exposed, as expected."

READINESS_HTTP_SCHEME=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].readinessProbe.httpGet.scheme}")
READINESS_HTTP_PATH=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].readinessProbe.httpGet.path}")
READINESS_HTTP_PORT=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].readinessProbe.httpGet.port}")

if [[ "$READINESS_HTTP_SCHEME" != "$EXPECTED_HTTP_SCHEME" ]]; then
    echo "Readiness probe HTTP scheme does not match. Expected: '$EXPECTED_HTTP_SCHEME', Found: '$READINESS_HTTP_SCHEME'."
    exit 1
fi

if [[ "$READINESS_HTTP_PATH" != "$EXPECTED_READINESS_PATH" ]]; then
    echo "Readiness probe HTTP path does not match. Expected: '$EXPECTED_READINESS_PATH', Found: '$READINESS_HTTP_PATH'."
    exit 1
fi

if [[ "$READINESS_HTTP_PORT" != "$EXPECTED_READINESS_PORT" ]]; then
    echo "Readiness probe HTTP port does not match. Expected: '$EXPECTED_READINESS_PORT', Found: '$READINESS_HTTP_PORT'."
    exit 1
fi

echo "Readiness probe is correctly configured to perform HTTP GET on port '$EXPECTED_READINESS_PORT'."

echo "Pod '$POD_NAME' has the correct container image, exposes port '$EXPECTED_PORT', and has a readiness probe with an HTTP GET request on port '$EXPECTED_PORT'."
exit 0
