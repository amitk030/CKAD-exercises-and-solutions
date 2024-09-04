### create a namespace `distro`.Run a `busybox` pod name `bbox` with command `i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done` in distro namespace. Tails logs of the pod. 
    
<details><summary>Solution</summary>
<p>

```bash
# create the namespace
k create ns distro

# create pod with the specified command
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: bbox
  name: bbox
  namespace: distro
spec:
  containers:
  - image: busybox
    name: bbox
    command: ["sh","-c","i=0; while true; do echo '$i: $(date)'; i=$((i+1)); sleep 1; done"]
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

# tail the logs
k logs bbox -n distro -f
```
</p>
</details>