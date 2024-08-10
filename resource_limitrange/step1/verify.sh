#!/bin/bash

NAMESPACE="pierre"
LIMIT_RANGE_NAME="memory-limit"

LIMIT_RANGE=$(kubectl get limitrange $LIMIT_RANGE_NAME -n $NAMESPACE -o json)

if [ -z "$LIMIT_RANGE" ]; then
  echo "LimitRange '$LIMIT_RANGE_NAME' does not exist in namespace '$NAMESPACE'."
  exit 1
fi

MIN_MEMORY=$(echo $LIMIT_RANGE | jq -r '.spec.limits[] | select(.type=="Container") | .min.memory')
MAX_MEMORY=$(echo $LIMIT_RANGE | jq -r '.spec.limits[] | select(.type=="Container") | .max.memory')

if [ "$MIN_MEMORY" == "300Mi" ] && [ "$MAX_MEMORY" == "800Mi" ]; then
  echo "Memory limits are correctly set to min=300Mi and max=800Mi."
else
  echo "Memory limits are not correctly set."
  echo "Expected: min=300Mi, max=800Mi"
  echo "Found: min=$MIN_MEMORY, max=$MAX_MEMORY"
  exit 1
fi

exit 0
