### Try creating a pod `server` with `nginx` image in `demo` namespace with resources request of `cpu=1.5` and `memory=1Gi` & limits of `cpu=2`, `memory=2Gi`. The pod creation will fail.
### Now update the pod to request `cpu=0.5`. Now the pod will be created successfully. 

** to check wait for pod to be in the running state

<details><summary>Solution</summary>
<p>

```bash
# create the server pod
k run server --image=nginx -n demo --dry-run=client -o yaml > pod.yaml

# update resources request and limits in the pod
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: server
  name: server
  namespace: demo
spec:
  containers:
  - image: nginx
    name: server
    resources:
      requests:
        cpu: "1.5" # use 0.5 in the second attempt
        memory: 1Gi
      limits:
        cpu: 2
        memory: 2Gi
  dnsPolicy: ClusterFirst
  restartPolicy: Always

# create the pod
k create -f pod.yaml
```

</p>
</details>