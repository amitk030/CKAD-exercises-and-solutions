### create a pod named `worker` in `nano` namespace. create two containers in it one with `nginx` image, and another with `busybox` image. In container with busybox image run bash command `sleep 3600`.
    
<details><summary>Solution</summary>
<p>

```bash
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: worker
  name: worker
  namespace: nano
spec:
  containers:
  - image: nginx
    name: nginx
  - image: busybox
    name: busybox
    command: ["sh","-c","sleep 3600"]
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

</p>
</details>