#!/bin/bash

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: tasker
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    readinessProbe:
      httpGet:
        path: /
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 10
EOF
