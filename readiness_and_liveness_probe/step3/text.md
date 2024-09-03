### create a pod `baldr` with image `busybox` execute `sleep 3600` command on the container. Add a liveness probe to execute command `env` & add initial delay of `5` seconds to it.

<details><summary>Solution</summary>
<p>

```bash
# generate pod yaml
k run baldr --image=busybox --dry-run=client -o yaml > pod.yaml

# update metadata of pod yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: baldr
  name: baldr
spec:
  containers:
  - image: busybox
    name: baldr
    command: ["sh","-c","sleep 3600"]
    livenessProbe:
      exec:
        command:
          - env
      initialDelaySeconds: 5
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
</p>
</details>