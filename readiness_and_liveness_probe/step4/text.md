### create a pod `frigg` with image `nginx` expose port `80` on the container. Add a liveness probe on container with initial delay of `5`seconds & at a period of `3` seconds with failure threshold set to `8`. 

<details><summary>Solution</summary>
<p>

```bash
# generate pod yaml
k run frigg --image=nginx --dry-run=client -o yaml > pod.yaml

# update metadata of pod yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: frigg
  name: frigg
spec:
  containers:
  - image: nginx
    name: frigg
    ports:
      - containerPort: 80
    livenessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 3
      failureThreshold: 8
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
</p>
</details>