### update existing deployment `nginx` in the default namespace, to change it's deployment strategy to `RollingUpdate` from `recreate` expose port `80` on the containers. And set maxSurge to `50%` while rolling update on the deployment

#### you can delete the existing deployment & recreate it.

<details><summary>Solution</summary>
<p>

```bash
#generate yaml file
k create deploy nginx --image=nginx:1.18.0 --replicas=4 --dry-run=client -o yaml > deploy.yaml

#update deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx
  name: nginx
spec:
  replicas: 4
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 50%
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:1.18.0
        name: nginx
        ports:
          - containerPort: 80
        resources: {}
status: {}


# create deployment
k create -f deploy.yaml
```

</p>
</details>