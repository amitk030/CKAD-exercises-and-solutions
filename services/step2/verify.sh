#!/bin/bash

for pod in pod-1 pod-2 pod-3; do
  POD_LABEL=$(kubectl get pod $pod -o jsonpath='{.metadata.labels.app}')
  if [ "$POD_LABEL" != "frontend" ]; then
    echo "Pod $pod does not have the label app=frontend"
    exit 1
  fi
done

for pod in pod-1 pod-2 pod-3; do
  POD_IP=$(kubectl get pod $pod -o jsonpath='{.status.podIP}')
  RESPONSE=$(curl -s $POD_IP:80)
  if [ "$RESPONSE" != "responding from $pod" ]; then
    echo "Pod $pod did not respond correctly"
    exit 1
  fi
done

SERVICE_TYPE=$(kubectl get svc frontend -o jsonpath='{.spec.type}')
if [ "$SERVICE_TYPE" != "ClusterIP" ]; then
  echo "Service frontend is not of type ClusterIP"
  exit 1
fi

SERVICE_PORT=$(kubectl get svc frontend -o jsonpath='{.spec.ports[0].port}')
if [ "$SERVICE_PORT" != "80" ]; then
  echo "Service frontend does not expose port 80"
  exit 1
fi

SERVICE_SELECTOR=$(kubectl get svc frontend -o jsonpath='{.spec.selector.app}')
if [ "$SERVICE_SELECTOR" != "frontend" ]; then
  echo "Service frontend does not have the selector app=frontend"
  exit 1
fi

echo "All checks passed"