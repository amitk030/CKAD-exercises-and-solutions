### schedule a pod with image `nginx` and name `bouncer`. Add tolerations to the pod for the following taint: `reserved=space:NoSchedule`.

<details><summary>Solution</summary>
<p>

```bash
# generate required pod yaml
k run bouncer --image=nginx --dry-run=client -o yaml > pod.yaml

# add service account name
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: bouncer
  name: bouncer
spec:
  tolerations:
    - key: "reserved"
      operator: "Equal"
      value: "space"
      effect: "NoSchedule"
  containers:
  - image: nginx
    name: bouncer
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

</p>
</details>