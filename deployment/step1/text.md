### create a `nginx` deployment with `nginx:1.18.0` image with `2` replicas, in the default namespace, expose port `80` on the containers.

<details><summary>Solution</summary>
<p>

```bash
#generate yaml file
k create deploy nginx --image=nginx:1.18.0 --replicas=2 --dry-run=client -o yaml > deploy.yaml

#update pod.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx
  name: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  strategy: {}
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