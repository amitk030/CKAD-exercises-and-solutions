### create a namespace `aarav` and create a pod with name `atharv` and `nginx` image, with the following requests `cpu=400m`, `memory=512Mi`. 

<details><summary>Solution</summary>
<p>

```bash
# create namespace
k create ns aarav

# k run atharv --image=nginx -n aarav --dry-run=client -o yaml > quota.yaml
apiVersion: v1
kind: pod
metadata:
  name: atharv
  namespace: aarav
spec:
  containers:
  - image: nginx
    name: atharv
    resources:
      requests:
        cpu: "400m"
        memory: 512Mi
  dnsPolicy: ClusterFirst
  restartPolicy: Always

k create -f pod.yaml
```

</p>
</details>