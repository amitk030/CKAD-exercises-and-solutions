kubectl create namespace setup;

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: busyboc
  name: bbox
  namespace: setup
spec:
  nodeName: node01
  containers:
  - image: busybox
    name: bbox
    resources: {}
    command: ["sh","-c","sleep 3600"]
    ports:
      - containerPort: 80
  dnsPolicy: ClusterFirst
  restartPolicy: Always
EOF