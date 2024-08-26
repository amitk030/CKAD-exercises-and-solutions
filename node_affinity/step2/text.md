### create a pod named `pod1` with `nginx` image. Schedule it on the `node01` node using `requiredDuringSchedulingIgnoredDuringExecution` node affinity, check the label on the node.
    
<details><summary>Solution</summary>
<p>

```bash
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: pod1
  name: pod1
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: scheduleNodes
            operator: Equal
            values:
            - True
  containers:
  - image: nginx
    name: pod1
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

</p>
</details>