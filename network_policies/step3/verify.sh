#!/bin/bash

kubectl get networkpolicy net-egress -n default > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "NetworkPolicy 'net-egress' does not exist."
  exit 1
fi

policy=$(kubectl get networkpolicy net-egress -n default -o jsonpath='{.spec.podSelector.matchLabels.run}')
if [ "$policy" != "busybox" ]; then
  echo "NetworkPolicy 'net-egress' does not target pods with label 'run: busybox'."
  exit 1
fi

policy=$(kubectl get networkpolicy net-egress -n default -o jsonpath='{.spec.policyTypes}')
if [[ ! "$policy" =~ "Egress" ]]; then
  echo "NetworkPolicy 'net-egress' does not include 'Egress' in policyTypes."
  exit 1
fi

policy=$(kubectl get networkpolicy net-egress -n default -o jsonpath='{.spec.egress[*].to[*].podSelector.matchLabels.run}')
if [[ ! "$policy" =~ "nginx" ]]; then
  echo "NetworkPolicy 'net-egress' does not allow traffic to pods with label 'run: nginx'."
  exit 1
fi

protocol=$(kubectl get networkpolicy net-egress -n default -o jsonpath='{.spec.egress[*].ports[*].protocol}')
port=$(kubectl get networkpolicy net-egress -n default -o jsonpath='{.spec.egress[*].ports[*].port}')
if [ "$protocol" != "TCP" ] || [ "$port" != "8080" ]; then
  echo "NetworkPolicy 'net-egress' does not allow traffic on port 8080 with protocol TCP."
  exit 1
fi

echo "NetworkPolicy 'net-egress' is correctly configured."
exit 0