#!/bin/bash

ROLEBINDING_NAME="developer-rolebinding"
USER_NAME="ardino"
ROLE_NAME="developer"

kubectl get rolebinding $ROLEBINDING_NAME > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Rolebinding $ROLEBINDING_NAME does not exist."
  exit 1
fi

kubectl get rolebinding $ROLEBINDING_NAME -o json | jq -e \
  'select(.subjects[] | select(.name == "'"$USER_NAME"'" and .kind == "User")) | select(.roleRef.name == "'"$ROLE_NAME"'")' > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "Rolebinding $ROLEBINDING_NAME is correctly configured."
else
  echo "Rolebinding $ROLEBINDING_NAME is not correctly configured."
  exit 1
fi