### Try creating a pod `server` with `nginx` image in `pierre` namespace with resources request of `memory=500Mi`. The pod creation will fail, once you define limitrange you need to provie limit for that resource in that namespace. 
### After checking pod failure add resource limit of `memory=700Mi`. Now the pod will be created successfully.

<details><summary>Solution</summary>
<p>

```bash
# create the server pod
k run server --image=nginx --dry-run=client -o yaml > pod.yaml

# pod file in first attempt
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: server
  name: server
  namespace: pierre
spec:
  containers:
  - image: nginx
    name: server
    resources:
      requests:
        memory: 500Mi
  dnsPolicy: ClusterFirst
  restartPolicy: Always

# pod file with updated limit
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: server
  name: server
  namespace: pierre
spec:
  containers:
  - image: nginx
    name: server
    resources:
      requests:
        memory: 500Mi
      limit:
        memory: 700Mi
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

</p>
</details>