kubectl create namespace setup

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: backend
  name: backend
  namespace: setup
spec:
  replicas: 3
  selector:
    matchLabels:
      app: backend
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: backend
    spec:
      containers:
      - image: nginx
        name: nginx
        ports:
          - containerPort: 80
        resources: {}
EOF