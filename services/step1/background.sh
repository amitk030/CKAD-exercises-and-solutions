kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
    app: myapp
  name: nginx
spec:
  nodeName: node01
  containers:
  - image: nginx
    name: nginx
    resources: {}
    ports:
      - containerPort: 80
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
EOF