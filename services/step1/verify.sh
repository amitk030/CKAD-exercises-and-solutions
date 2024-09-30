#!/bin/bash

POD_NODE=$(kubectl get pods -o jsonpath='{.items[?(@.metadata.labels.app=="myapp")].spec.nodeName}')
if [ "$POD_NODE" != "node01" ]; then
  echo "nginx pod is not deployed on node01"
  exit 1
fi

CONTAINER_PORT=$(kubectl get pods -o jsonpath='{.items[?(@.metadata.labels.app=="myapp")].spec.containers[0].ports[0].containerPort}')
if [ "$CONTAINER_PORT" != "80" ]; then
  echo "Container port is not exposed at 80"
  exit 1
fi

POD_LABEL=$(kubectl get pods -o jsonpath='{.items[?(@.metadata.labels.app=="myapp")].metadata.labels.app}')
if [ "$POD_LABEL" != "myapp" ]; then
  echo "Pod label is not app=myapp"
  exit 1
fi

SERVICE=$(kubectl get svc ng-svc --ignore-not-found)
if [ -z "$SERVICE" ]; then
  echo "NodePort service ng-svc does not exist"
  exit 1
fi

NODE_PORT=$(kubectl get svc ng-svc -o jsonpath='{.spec.ports[0].nodePort}')
if [ "$NODE_PORT" != "30002" ]; then
  echo "NodePort is not 30002"
  exit 1
fi

SERVICE_SELECTOR=$(kubectl get svc ng-svc -o jsonpath='{.spec.selector.app}')
if [ "$SERVICE_SELECTOR" != "myapp" ]; then
  echo "Service selector is not app=myapp"
  exit 1
fi

SERVICE_PORT=$(kubectl get svc ng-svc -o jsonpath='{.spec.ports[0].port}')
TARGET_PORT=$(kubectl get svc ng-svc -o jsonpath='{.spec.ports[0].targetPort}')
if [ "$SERVICE_PORT" != "80" ] || [ "$TARGET_PORT" != "80" ]; then
  echo "Service port or targetPort is not 80"
  exit 1
fi

echo "All checks passed"