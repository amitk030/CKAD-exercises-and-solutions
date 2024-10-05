#!/bin/bash

kubectl get networkpolicy net-ingress > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-ingress' does not exist."
  exit 1
fi

policy=$(kubectl get networkpolicy net-ingress -o yaml)

echo "$policy" | grep -q "matchLabels:\s*type: deployment"
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-ingress' does not target pods with label 'type: deployment'."
  exit 1
fi

echo "$policy" | grep -q "from:\s*- podSelector:\s*matchLabels:\s*app: serve"
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-ingress' does not allow traffic from pods with label 'app: serve'."
  exit 1
fi

echo "$policy" | grep -q "ports:\s*- protocol: TCP\s*port: 80"
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-ingress' does not allow traffic on port 80."
  exit 1
fi

echo "NetworkPolicy 'net-ingress' is correctly configured."
exit 0