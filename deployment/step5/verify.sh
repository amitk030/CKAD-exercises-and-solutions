#!/bin/bash

DEPLOYMENT_NAME="nginx"
NAMESPACE="default"
EXPECTED_MIN_REPLICAS=5
EXPECTED_MAX_REPLICAS=10

if ! kubectl get hpa "$DEPLOYMENT_NAME" -n "$NAMESPACE" >/dev/null 2>&1; then
    echo "Horizontal Pod Autoscaler (HPA) for deployment '$DEPLOYMENT_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi

echo "HPA for deployment '$DEPLOYMENT_NAME' exists in namespace '$NAMESPACE'."

MIN_REPLICAS=$(kubectl get hpa "$DEPLOYMENT_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.minReplicas}")
if [[ "$MIN_REPLICAS" -ne "$EXPECTED_MIN_REPLICAS" ]]; then
    echo "HPA min replicas do not match the expected value '$EXPECTED_MIN_REPLICAS'. Found: '$MIN_REPLICAS'."
    exit 1
fi

echo "HPA minimum replicas are '$EXPECTED_MIN_REPLICAS', as expected."

MAX_REPLICAS=$(kubectl get hpa "$DEPLOYMENT_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.maxReplicas}")
if [[ "$MAX_REPLICAS" -ne "$EXPECTED_MAX_REPLICAS" ]]; then
    echo "HPA max replicas do not match the expected value '$EXPECTED_MAX_REPLICAS'. Found: '$MAX_REPLICAS'."
    exit 1
fi

echo "HPA maximum replicas are '$EXPECTED_MAX_REPLICAS', as expected."

echo "HPA for deployment '$DEPLOYMENT_NAME' is correctly configured with min replicas of '$EXPECTED_MIN_REPLICAS' and max replicas of '$EXPECTED_MAX_REPLICAS'."
exit 0
