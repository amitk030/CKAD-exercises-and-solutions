#!/bin/bash

kubectl get networkpolicy net-egress -n default > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-egress' does not exist."
  exit 1
fi

policy=$(kubectl get networkpolicy net-egress -n default -o yaml)

echo "$policy" | grep -q "matchLabels:\s*run: busybox"
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-egress' does not target pods with label 'run: busybox'."
  exit 1
fi

echo "$policy" | grep -q "policyTypes:\s*- Egress"
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-egress' does not include 'Egress' in policyTypes."
  exit 1
fi

echo "$policy" | grep -q "to:\s*- podSelector:\s*matchLabels:\s*run: nginx"
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-egress' does not allow traffic to pods with label 'run: nginx'."
  exit 1
fi

echo "$policy" | grep -q "ports:\s*- protocol: TCP\s*port: 8080"
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-egress' does not allow traffic on port 8080."
  exit 1
fi

echo "NetworkPolicy 'net-egress' is correctly configured."
exit 0