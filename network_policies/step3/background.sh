#!/bin/bash

# Create YAML for nginx pod
kubectl create -f -<<EOF
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    run: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 8080
EOF

# Create YAML for busybox pod
kubectl create -f -<<EOF
apiVersion: v1
kind: Pod
metadata:
  name: busybox
  labels:
    run: busybox
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh", "-c", "while true; do echo hello; sleep 10;done"]
    ports:
    - containerPort: 80
EOF

echo "nginx and busybox pods have been created."