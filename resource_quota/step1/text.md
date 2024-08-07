### create a namespace `demo` and create a resource quota `demo-quota` with hard requests `cpu=1`, `memory=1Gi` and hard limits `cpu=2`, `memory=2Gi`. 

<details><summary>Solution</summary>
<p>

```bash
# create namespace
k create ns demo

# create resource quota > quota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: demo-quota
  namespace: demo
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi

k create -f quota.yaml

k create quota demo-quota -n demo --hard=requests.cpu=1,requests.memory=1Gi,limits.cpu=2,limits.memory=2Gi 
```

</p>
</details>