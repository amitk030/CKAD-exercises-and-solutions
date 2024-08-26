### create a pod named `pod1` with `nginx` image. Set node affinity for node `node01` using `requiredDuringSchedulingIgnoredDuringExecution`, check the label on the node.
    
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
            operator: In
            values:
            - "true"
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