### Add label `name=master` to `controlplane` node. create a pod named `p1` with `nginx` image. Schedule it on the `controlplane` node using node selector.

<details><summary>Solution</summary>
<p>

```bash
# Add label to node
k label node controlplane name=master
```

```bash
# add node selector to pod
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: p1
  name: p1
spec:
  nodeSelector:
    name: master
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