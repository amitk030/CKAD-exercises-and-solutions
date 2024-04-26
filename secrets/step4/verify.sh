#!/bin/bash

NAMESPACE="default"
SECRET_NAME="source"
POD_NAME="nginx"
EXPECTED_KEY="app"
EXPECTED_VALUE="v1"

if kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" &> /dev/null; then
    ACTUAL_VALUE=$(kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o jsonpath="{.data.$EXPECTED_KEY}" | base64 -d)
    if [ "$EXPECTED_VALUE" != "$ACTUAL_VALUE" ]; then
      exit 1
    fi

    if kubectl get pod "$POD_NAME" -n "$NAMESPACE" &> /dev/null; then
        ACTUAL_SECRET_NAME=$(kubectl get pod nginx -o jsonpath="{.spec.containers[0].env[?(@.name=='APP_VERSION')].valueFrom.secretKeyRef.name}")
        if [ "$ACTUAL_SECRET_NAME" = "$SECRET_NAME" ]; then
            exit 0
        else
            exit 1
        fi
    else
        exit 1
    fi
else
    exit 1
fi
