### create a pod `vids` with image `nginx`. Add a readiness probe to the container to exec `ls` command on it. 

<details><summary>Solution</summary>
<p>

```bash
# generate pod yaml
k run vids --image=nginx --dry-run=client -o yaml > pod.yaml

# update metadata of pod yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: vids
  name: vids
spec:
  containers:
  - image: nginx
    name: vids
    readinessProbe:
      exec:
        command:
          - ls
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
</p>
</details>