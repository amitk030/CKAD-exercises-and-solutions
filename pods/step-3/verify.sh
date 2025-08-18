#!/bin/bash

NAMESPACE="default"
POD_NAME="theta"
EXPECTED_IMAGE="nginx"
EXPECTED_STATUS="Running"

# Check if the pod exists
if kubectl get pod -n "$NAMESPACE" "$POD_NAME" &> /dev/null; then
    echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."
    
    # Check the pod status
    POD_STATUS=$(kubectl get pod -n "$NAMESPACE" "$POD_NAME" -o jsonpath='{.status.phase}')
    echo "Pod status: $POD_STATUS"
    
    if [ "$POD_STATUS" == "$EXPECTED_STATUS" ]; then
        echo "Pod '$POD_NAME' is running successfully."
    else
        echo "Error: Pod '$POD_NAME' is not running. Current status: $POD_STATUS"
        echo "Checking pod events for more details..."
        kubectl describe pod -n "$NAMESPACE" "$POD_NAME" | grep -A 10 "Events:"
        exit 1
    fi
    
    # Check the image
    ACTUAL_IMAGE=$(kubectl get pod -n "$NAMESPACE" "$POD_NAME" -o jsonpath='{.spec.containers[0].image}')
    if [ "$ACTUAL_IMAGE" == "$EXPECTED_IMAGE" ]; then
        echo "Pod '$POD_NAME' has the correct image: $EXPECTED_IMAGE."
    else
        echo "Error: Pod '$POD_NAME' has incorrect image. Expected: $EXPECTED_IMAGE, Actual: $ACTUAL_IMAGE."
        exit 1
    fi
    
    # Check if the pod is ready
    READY_STATUS=$(kubectl get pod -n "$NAMESPACE" "$POD_NAME" -o jsonpath='{.status.containerStatuses[0].ready}')
    if [ "$READY_STATUS" == "true" ]; then
        echo "Pod '$POD_NAME' is ready and healthy."
    else
        echo "Error: Pod '$POD_NAME' is not ready."
        exit 1
    fi
    
    # Verify no recent error events
    RECENT_ERRORS=$(kubectl get events -n "$NAMESPACE" --sort-by='.lastTimestamp' | grep -i "error\|failed" | grep "$POD_NAME" | tail -5)
    if [ -n "$RECENT_ERRORS" ]; then
        echo "Warning: Recent errors found for pod '$POD_NAME':"
        echo "$RECENT_ERRORS"
    else
        echo "No recent errors found for pod '$POD_NAME'."
    fi
    
    echo "✅ Verification successful: Pod '$POD_NAME' is running correctly with image '$EXPECTED_IMAGE'."
    exit 0
    
else
    echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    echo "Make sure you have created the pod with the correct name and image."
    exit 1
fi 