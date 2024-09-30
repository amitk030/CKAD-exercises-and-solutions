#!/bin/bash

NAMESPACE="setup"
DEPLOYMENT_NAME="backend"
SERVICE_NAME="dep-svc"
SERVICE_PORT="80"

DEPLOYMENT_EXISTS=$(kubectl get deployment $DEPLOYMENT_NAME -n $NAMESPACE --ignore-not-found)
if [ -z "$DEPLOYMENT_EXISTS" ]; then
  echo "Deployment $DEPLOYMENT_NAME does not exist in namespace $NAMESPACE"
  exit 1
fi

SERVICE_EXISTS=$(kubectl get svc $SERVICE_NAME -n $NAMESPACE --ignore-not-found)
if [ -z "$SERVICE_EXISTS" ]; then
  echo "Service $SERVICE_NAME does not exist in namespace $NAMESPACE"
  exit 1
fi

SERVICE_PORT_EXPOSED=$(kubectl get svc $SERVICE_NAME -n $NAMESPACE -o jsonpath='{.spec.ports[0].port}')
if [ "$SERVICE_PORT_EXPOSED" != "$SERVICE_PORT" ]; then
  echo "Service $SERVICE_NAME does not expose port $SERVICE_PORT"
  exit 1
fi

echo "All checks passed"