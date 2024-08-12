#!/bin/bash

NAMESPACE="jupiter"
POD_NAME="carpo"
EXPECTED_IMAGE="nginx"
EXPECTED_LIMIT_MEMORY="400Mi"

POD=$(kubectl get pod $POD_NAME -n $NAMESPACE -o json)

if [ -z "$POD" ]; then
  echo "Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
  exit 1
fi

IMAGE=$(echo $POD | jq -r '.spec.containers[] | select(.name=="carpo") | .image')
LIMIT_MEMORY=$(echo $POD | jq -r '.spec.containers[] | select(.name=="carpo") | .resources.limits.memory')

if [ "$IMAGE" != "$EXPECTED_IMAGE" ]; then
  echo "Image is not correctly set."
  echo "Expected: $EXPECTED_IMAGE"
  echo "Found: $IMAGE"
  exit 1
fi

if [ "$LIMIT_MEMORY" != "$EXPECTED_LIMIT_MEMORY" ]; then
  echo "Memory limit is not correctly set."
  echo "Expected: $EXPECTED_LIMIT_MEMORY"
  echo "Found: $LIMIT_MEMORY"
  exit 1
fi

echo "Pod '$POD_NAME' in namespace '$NAMESPACE' has the correct image and memory limit configuration."
exit 0
