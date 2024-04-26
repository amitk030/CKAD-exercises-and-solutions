#!/bin/bash

NAMESPACE="default"
POD_NAME="db"
EXPECTED_SECRET_NAME="mysqlcred"

if kubectl get pod "$POD_NAME" -n "$NAMESPACE" &> /dev/null; then
    echo "Pod '$POD_NAME' exists in namespace '$NAMESPACE'."

    SECRET_NAME=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].envFrom[0].secretRef.name}' 2>/dev/null)
    if [ "$SECRET_NAME" != "$EXPECTED_SECRET_NAME" ]; then
        echo "Error: Pod '$POD_NAME' does not use a secret for environment variables."
        exit 1
    fi

    if kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" &> /dev/null; then
        echo "Secret '$SECRET_NAME' exists in namespace '$NAMESPACE'."

        MYSQL_ROOT_PASSWORD=$(kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o jsonpath="{.data.MYSQL_ROOT_PASSWORD}" | base64 --decode)
        MYSQL_USER=$(kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o jsonpath="{.data.MYSQL_USER}" | base64 --decode)
        MYSQL_PASSWORD=$(kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o jsonpath="{.data.MYSQL_PASSWORD}" | base64 --decode)
        MYSQL_DATABASE=$(kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o jsonpath="{.data.MYSQL_DATABASE}" | base64 --decode)
        exit 0
    else
        echo "Error: Secret '$SECRET_NAME' does not exist in namespace '$NAMESPACE'."
        exit 1
    fi
else
    echo "Error: Pod '$POD_NAME' does not exist in namespace '$NAMESPACE'."
    exit 1
fi
