kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: pod-1
  labels:
    app: frontend
spec:
  volumes:
  - name: html-volume
    emptyDir: {}
  initContainers:
  - name: init-c
    image: busybox
    volumeMounts:
    - name: html-volume
      mountPath: /usr/share/nginx/html
    command: ['sh', '-c', 'echo "responding from pod-1" > /usr/share/nginx/html/index.html']
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - name: html-volume
      mountPath: /usr/share/nginx/html
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-2
  labels:
    app: frontend
spec:
  volumes:
  - name: html-volume
    emptyDir: {}
  initContainers:
  - name: init-c
    image: busybox
    volumeMounts:
    - name: html-volume
      mountPath: /usr/share/nginx/html
    command: ['sh', '-c', 'echo "responding from pod-2" > /usr/share/nginx/html/index.html']
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - name: html-volume
      mountPath: /usr/share/nginx/html
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-3
  labels:
    app: frontend
spec:
  volumes:
  - name: html-volume
    emptyDir: {}
  initContainers:
  - name: init-c
    image: busybox
    volumeMounts:
    - name: html-volume
      mountPath: /usr/share/nginx/html
    command: ['sh', '-c', 'echo "responding from pod-3" > /usr/share/nginx/html/index.html']
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - name: html-volume
      mountPath: /usr/share/nginx/html
EOF