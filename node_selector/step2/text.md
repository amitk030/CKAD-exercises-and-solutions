### Create a pod named `p2` with image `nginx`. Schedule it on the `controlplane` node using nodeName.

<details><summary>Solution</summary>
<p>

```bash
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: p1
  name: p1
spec:
  nodeName: controlplane
  containers:
  - image: nginx
    name: p1
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

</p>
</details>