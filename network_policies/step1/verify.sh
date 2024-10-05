#!/bin/bash

kubectl get networkpolicy net-ingress > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-ingress' does not exist."
  exit 1
fi

policy=$(kubectl get networkpolicy net-ingress -o jsonpath='{.spec.podSelector.matchLabels.app}')
if [ "$policy" != "nginx" ]; then
  echo "NetworkPolicy 'net-ingress' does not target pods with label 'app: nginx'."
  exit 1
fi

policy=$(kubectl get networkpolicy net-ingress -o jsonpath='{.spec.ingress[*].from[*].podSelector.matchLabels.app}')
if [[ ! "$policy" =~ "serve" ]]; then
  echo "NetworkPolicy 'net-ingress' does not allow traffic from pods with label 'app: serve'."
  exit 1
fi

protocol=$(kubectl get networkpolicy net-ingress -o jsonpath='{.spec.ingress[*].ports[*].protocol}')
port=$(kubectl get networkpolicy net-ingress -o jsonpath='{.spec.ingress[*].ports[*].port}')
if [ "$protocol" != "TCP" ] || [ "$port" != "80" ]; then
  echo "NetworkPolicy 'net-ingress' does not allow traffic on port 80 with protocol TCP."
  exit 1
fi

echo "NetworkPolicy 'net-ingress' is correctly configured."
exit 0