### Create a pod named `p2` with image `nginx`. Schedule it on the `node01` node using nodeName.

<details><summary>Solution</summary>
<p>

```bash
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: p2
  name: p2
spec:
  nodeName: node01
  containers:
  - image: nginx
    name: p2
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

</p>
</details>