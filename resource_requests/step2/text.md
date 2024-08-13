### create a namespace `omega` and create a pod with name `serve` and `nginx` image, with the following requests `cpu=400m`, `memory=512Mi` & limits `cpu=1`, `memory=1Gi`. 

<details><summary>Solution</summary>
<p>

```bash
# create namespace
k create ns omega

# k run serve --image=nginx -n omega --dry-run=client -o yaml > quota.yaml
apiVersion: v1
kind: pod
metadata:
  name: serve
  namespace: omega
spec:
  containers:
  - image: nginx
    name: serve
    resources:
      requests:
        cpu: "400m"
        memory: 512Mi
      limits:
        cpu: 1
        memory: 1Gi
  dnsPolicy: ClusterFirst
  restartPolicy: Always

k create -f pod.yaml
```

</p>
</details>