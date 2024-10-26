#!/bin/bash

# Check if the role 'developer' exists
role_exists=$(kubectl get roles | grep -w 'developer')

if [ -z "$role_exists" ]; then
  echo "Role 'developer' does not exist."
  exit 1
fi

# Get the rules of the 'developer' role
rules=$(kubectl get role developer -o jsonpath='{.rules}')

# Check if the role has permissions for 'pods' and 'services'
if echo "$rules" | grep -q '"pods"' && echo "$rules" | grep -q '"services"'; then
  echo "Role 'developer' has permissions for 'pods' and 'services'."
else
  echo "Role 'developer' does not have the required permissions."
  exit 1
fi