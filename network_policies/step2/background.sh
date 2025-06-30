#!/bin/bash

kubectl create deployment nginx-1 --image=nginx --replicas=2

kubectl expose deployment nginx-1 --name=ngx-svc-1 --port=80 --target-port=80

# Write the NetworkPolicy YAML to net-ingress.yaml
cat <<EOF > net-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: net-ingress
  namespace: default
spec:
  podSelector:
    matchLabels:
      type: deployment
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: serve
    ports:
    - protocol: TCP
      port: 80
EOF
