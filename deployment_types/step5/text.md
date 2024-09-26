### There exist a namespace `canary` with deployment `app-v1` and service `app-svc`.Make request to the service and it returns `App Version V1`. Create another deployment `app-v2` with image `nginx:1.19.8` such that `50%` of traffic directed to it, after deploying `app-v2`. Making request to the service returns `App Version V1` if request goes to `app-v1` & and `App Version V2` if request goes to `app-v2`. use label `app=frontend`.


<details><summary>Solution</summary>
<p>

```bash
# make request to the svc
# check service ip
k get svc -n canary

wget -qO- <app-svc-cluster-ip>

# create deployment app-v2
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx
  name: app-v2
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
          command: ["sh","-c","echo 'App Version V2' > /sd/index.html"]
          volumeMounts:
            - name: store
              mountPath: /sd
      containers:
      - image: nginx:1.19.8
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

# make request to the svc
# check service ip
k get svc -n canary

wget -qO- <app-svc-cluster-ip>


# try polling by running a temporary pod
k run temp --image=busybox --rm -ti -- bin/sh

# in shell run the following command
while true; do
  wget -qO- http://app-svc.canary.svc.cluster.local:80
  sleep 1
done
```
</p>
</details>