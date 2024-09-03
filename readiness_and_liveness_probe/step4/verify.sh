#!/bin/bash

POD_NAME="frigg"
EXPECTED_IMAGE="nginx"
EXPECTED_PORT=80
EXPECTED_LIVENESS_INITIAL_DELAY=5
EXPECTED_LIVENESS_PERIOD=3
EXPECTED_LIVENESS_FAILURE_THRESHOLD=8

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

LIVENESS_INITIAL_DELAY=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].livenessProbe.initialDelaySeconds}")
LIVENESS_PERIOD=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].livenessProbe.periodSeconds}")
LIVENESS_FAILURE_THRESHOLD=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[0].livenessProbe.failureThreshold}")

if [[ "$LIVENESS_INITIAL_DELAY" -ne "$EXPECTED_LIVENESS_INITIAL_DELAY" ]]; then
    echo "Liveness probe initial delay does not match the expected value of '$EXPECTED_LIVENESS_INITIAL_DELAY' seconds. Found: '$LIVENESS_INITIAL_DELAY' seconds."
    exit 1
fi

if [[ "$LIVENESS_PERIOD" -ne "$EXPECTED_LIVENESS_PERIOD" ]]; then
    echo "Liveness probe period does not match the expected value of '$EXPECTED_LIVENESS_PERIOD' seconds. Found: '$LIVENESS_PERIOD' seconds."
    exit 1
fi

if [[ "$LIVENESS_FAILURE_THRESHOLD" -ne "$EXPECTED_LIVENESS_FAILURE_THRESHOLD" ]]; then
    echo "Liveness probe failure threshold does not match the expected value of '$EXPECTED_LIVENESS_FAILURE_THRESHOLD'. Found: '$LIVENESS_FAILURE_THRESHOLD'."
    exit 1
fi

echo "Liveness probe is correctly configured with an initial delay of '$EXPECTED_LIVENESS_INITIAL_DELAY' seconds, a period of '$EXPECTED_LIVENESS_PERIOD' seconds, and a failure threshold of '$EXPECTED_LIVENESS_FAILURE_THRESHOLD'."

echo "Pod '$POD_NAME' is correctly configured with the nginx image, exposes port '$EXPECTED_PORT', and has the expected liveness probe settings."
exit 0
