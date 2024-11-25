#!/bin/bash

CRD_NAME="bustickets.ticket.com"

kubectl get crd $CRD_NAME

if [ $? -eq 0 ]; then
  echo "Custom Resource Definition '$CRD_NAME' exists."
  
  kubectl get crd $CRD_NAME -o yaml | grep -E "name:|group:|versions:|scope:|names:"
  
  FIELDS=$(kubectl get crd $CRD_NAME -o jsonpath='{.spec.versions[0].schema.openAPIV3Schema.properties.spec.properties}')
  
  if echo $FIELDS | jq -e '.from.type == "string"' && \
     echo $FIELDS | jq -e '.to.type == "string"' && \
     echo $FIELDS | jq -e '.seats.type == "integer"'; then
    echo "CRD has the correct fields: 'from' (string), 'to' (string), 'seats' (integer)."
  else
    echo "CRD does not have the correct fields."
    exit 1
  fi
  
  SCOPE=$(kubectl get crd $CRD_NAME -o jsonpath='{.spec.scope}')
  
  if [ "$SCOPE" == "Namespaced" ]; then
    echo "CRD is namespaced."
  else
    echo "CRD is not namespaced."
    exit 1
  fi
else
  echo "Custom Resource Definition '$CRD_NAME' does not exist."
  exit 1
fi