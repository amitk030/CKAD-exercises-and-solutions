#!/bin/bash

kubectl create namespace blue-green

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx
  name: blue
  namespace: blue-green
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
        mark: blue
    spec:
      initContainers:
        - image: busybox
          name: busybox
          command: ["sh","-c","echo 'This is blue deployment' > /sd/index.html"]
          volumeMounts:
            - name: store
              mountPath: /sd
      containers:
      - image: nginx:1.18.0
        name: nginx
        ports:
          - containerPort: 80
        volumeMounts:
          - name: store
            mountPath: /usr/share/nginx/html
        resources: {}
      volumes:
        - name: store
          emptyDir: {}
EOF

kubectl expose deployment blue --type=ClusterIP --name=nginx-svc --port=80 --target-port=80 --selector=mark=blue --namespace=blue-green

