#!/bin/bash

NAMESPACE="demeter"

if kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
    echo "Namespace '$NAMESPACE' exists."
else
    echo "Namespace '$NAMESPACE' does not exist."
    exit 1
fi
