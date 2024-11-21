#!/bin/bash

POD_NAME=$(kubectl get pods --selector=job-name=simple-job --output=jsonpath='{.items[*].metadata.name}')

LOGS=$(kubectl logs $POD_NAME)

if echo "$LOGS" | grep -q "Hello, Kubernetes!"; then
  echo "The job logs contain 'Hello, Kubernetes!'"
else
  echo "The job logs do not contain 'Hello, Kubernetes!'"
fi