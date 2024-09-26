### There exist a namespace `blue-green`, a deployment named `blue`. Also a service named `nginx-svc` exposing the `nginx` deployment on port `80`. If you request the service it will return `This is blue deployment`. Create another deployment named `green` with label `mark=green` & `image=nginx:1.19.8` and make changes such that it should return `This is green deployment` while calling `nginx-svc` service. Delete `blue` deployment.

#### make request to the service now it should return `This is green deployment`(by running `wget -qO- <nginx-svc-ip-address>`).

<details><summary>Solution</summary>
<p>

```bash
# update the deployment
      ...
      metadata:
        creationTimestamp: null
        labels:
          app: nginx
        name: green
      ...
      ...
      labels:
        app: nginx
        mark: green
    spec:
      initContainers:
        - image: busybox
          name: busybox
          command: ["sh","-c","echo 'This is green deployment' > /sd/index.html"]
      ...
      ...
      containers:
        - image: nginx:1.19.8
          name: nginx
      ...
      ...

# edit nginx-svc
k edit svc nginx-svc -n blue-green
# and update selector to mark: green
...
selector:
  mark: green
...


# check service ip
k get svc -n blue-green

# NAME        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
# nginx-svc   ClusterIP   10.110.196.45   <none>        80/TCP    6m16s

# make request
wget -qO- <nginx-svc-cluster-ip>

# returns: This is green deployment
```
</p>
</details>