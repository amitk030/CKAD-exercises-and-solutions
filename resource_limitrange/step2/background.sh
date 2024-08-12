#!/bin/bash

NAMESPACE="jupiter"
LIMIT_RANGE_NAME="limits"

kubectl create namespace $NAMESPACE

cat <<EOF > limitrange.yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: $LIMIT_RANGE_NAME
  namespace: $NAMESPACE
spec:
  limits:
  - max:
      memory: 800Mi
    min:
      memory: 200Mi
    type: Container
EOF

kubectl apply -f limitrange.yaml

rm limitrange.yaml

echo "Namespace '$NAMESPACE' created with LimitRange '$LIMIT_RANGE_NAME' set on memory (min=200Mi, max=800Mi)."
