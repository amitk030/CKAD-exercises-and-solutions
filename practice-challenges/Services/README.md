## Service Account

[Service Account](https://kubernetes.io/docs/concepts/security/service-accounts/)
</br>

[Service Type](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)

[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### A `nginx` pod is deployed on node `node01` with container port exposed at `80` and label `app=myapp`. Create a NodePort service named `ng-svc` to expose `nginx` pod on node Port `30002`.

<details><summary>Setup</summary>
  <p>

```bash
# copy these contents & create the pod
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
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
```

  </p>
</details>

<details><summary>Solution</summary>
  <p>

  ```bash
  # create service yaml file
  k create svc nodeport ng-svc --tcp=80:80 --target-port=80 --dry-run=client -o yaml > service.yaml
  
  # update selector in service yaml file
  apiVersion: v1
  kind: Service
  metadata:
    creationTimestamp: null
    labels:
      app: ng-svc
    name: ng-svc
  spec:
    ports:
    - name: ports
      nodePort: 30002
      port: 80
      protocol: TCP
      targetPort: 80
    selector:
      app: myapp
    type: NodePort

  # create service
  k create -f service.yaml

  # get the node ip address
  k get nodes -o wide

  # make request on the node ip with port 30002
  wget -qO- <node01-ip>:30002
  ```

  </p>
</details>


2. ### There exist 3 `nginx` pods with names `pod-1`, `pod-2` & `pod-3` with label `app=frontend`. If you make a request to each pod on their ip they will return __responding from pod-x__ . Now create a service `frontend` with type `ClusterIP` exposing these pods as a service on port `80`.

### Try polling with this script to the service & see the results
```bash
# get the service ip
k get svc

# run
while true; do curl -s <service-ip>; sleep 1; done

# it will distribute request to the 3 created pods
```

<details><summary>Setup</summary>
  <p>

```bash
# copy these contents & create the pod
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
```

  </p>
</details>

<details><summary>Solution</summary>
  <p>

  ```bash
  # create service yaml file
  apiVersion: v1
  kind: Service
  metadata:
    name: frontend
  spec:
    selector:
      app: frontend
    ports:
      - protocol: TCP
        port: 80
        targetPort: 80
    type: ClusterIP

  # create service
  k create -f service.yaml
  
  ```

  </p>
</details>


3. ### There exist a `bbox` pod in `setup` namespace. Expose pod on port `80`.

<details><summary>Setup</summary>
<p>

```bash
# copy these contents & create the pod
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: busyboc
  name: bbox
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
```

</p>
</details>

<details><summary>Solution</summary>
  <p>

  ```bash
  # create pod on port 80
   k expose pod bbox --port=80 --name=bbox-svc --namespace=setup
  ```

  </p>
</details>


4. ### There exist a deployment named `backend` in `setup` namespace. Create a service `dep-svc` that expose the deployment on port `80`.

<details><summary>Setup</summary>
<p>

```bash
# copy these contents & create the pod
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
```

</p>
</details>

<details><summary>Solution</summary>
  <p>

  ```bash
  # create deploy on port 80
   k expose deploy backend --name=dep-svc --type=ClusterIP --port=80 --namespace=setup
  ```

  </p>
</details>