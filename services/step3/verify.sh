#!/bin/bash

NAMESPACE="setup"
POD_NAME="bbox"
SERVICE_NAME="bbox-svc"
SERVICE_PORT="80"

POD_EXISTS=$(kubectl get pod $POD_NAME -n $NAMESPACE --ignore-not-found)
if [ -z "$POD_EXISTS" ]; then
  echo "Pod $POD_NAME does not exist in namespace $NAMESPACE"
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