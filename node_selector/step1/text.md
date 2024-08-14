### Add label `name=master` to `node01` node. create a pod named `p1` with `nginx` image. Schedule it on the `node01` node using node selector.

<details><summary>Solution</summary>
<p>

```bash
# Add label to node
k label node node01 name=master
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