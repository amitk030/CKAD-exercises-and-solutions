### Create a `bitto` pod with `busybox` image. It runs a command `ls \here`. Debug the issue check why it's not running & write your error in `issue.txt`file. 

<details><summary>Solution</summary>
<p>

```bash

# create pod with the specified command
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: bitto
  name: bitto
spec:
  containers:
  - image: busybox
    name: bitto
    command: ["sh","-c","ls /here"]
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

# check details of the pod
k describe po bitto

# check the logs
k logs bitto

# write the logs in issue.txt
k logs bitto > issue.txt
```
</p>
</details>