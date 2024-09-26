### create a deployment `nginx` with `nginx:1.18.0` image with `4` replicas, in the default namespace, with deployment strategy of `recreate` expose port `80` on the containers.

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
    type: Recreate
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