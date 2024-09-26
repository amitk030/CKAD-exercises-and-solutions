#!/bin/bash

kubectl create namespace canary

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx
  name: app-v1
  namespace: canary
spec:
  replicas: 2
  selector:
    matchLabels:
      app: frontend
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: frontend
    spec:
      initContainers:
        - image: busybox
          name: busybox
          command: ["sh","-c","echo 'App Version V1' > /sd/index.html"]
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

kubectl expose deployment app-v1 --type=ClusterIP --name=app-svc --port=80 --target-port=80 --selector=app=frontend --namespace=canary
echo "Namespace, service and deployment  created successfully."