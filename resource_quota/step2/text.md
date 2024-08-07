### Try creating a pod `server` with `nginx` image in `demo` namespace with resources request of `cpu=1.5` and `memory=1Gi` & limits of `cpu=2`, `memory=2Gi`. The pod creation will fail.
### Now update the pod to request `cpu=0.5`. Now the pod will be created successfully. 

<details><summary>Solution</summary>
<p>

```bash
# create the server pod
k run server --image=nginx -n demo --dry-run=client -o yaml > pod.yaml

# update resources request and limits in the pod
apiVersion: v1
kind: ResourceQuota
metadata:
  name: demo-quota
  namespace: demo
spec:
  hard:
    requests.cpu: "1.5" # update it to 0.5 in second attempt
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi

# create the pod
k create -f pod.yaml
```

</p>
</details>