### create a pod `aided` with image `nginx` expose port `80` on the container. Add a readiness probe to make http get request on port `80`. 

<details><summary>Solution</summary>
<p>

```bash
# generate pod yaml
k run aided --image=nginx --dry-run=client -o yaml

# update metadata of pod yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: aided
  name: aided
spec:
  containers:
  - image: nginx
    name: aided
    ports:
      - containerPort: 80
    readinessProbe:
      httpGet:
        path: /
        port: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
</p>
</details>