### create a pod `carpo` in `jupiter` namespace with `nginx` image. The namespace and a limitrange named `limits` already exist, set memory limit on `carpo` pod to be half of the max value set in the `limits`.

<details><summary>Solution</summary>
<p>

```bash
# create the carpo pod
k run carpo --image=nginx -n jupiter --dry-run=client -o yaml > pod.yaml

# pod file with updated limit
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: carpo
  name: carpo
  namespace: jupiter
spec:
  containers:
  - image: nginx
    name: carpo
    resources:
      limits:
        memory: 400Mi
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

</p>
</details>