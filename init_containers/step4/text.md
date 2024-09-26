### Take `stew` pod created from `demeter` namespace. Export port `80` of `nginx` container. Check IP of the running pod and make request on port `80`.

<details><summary>Solution</summary>
<p>

```bash
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: stew
  name: stew
  namespace: demeter
spec:
  initContainers:
    - image: busybox
      name: setup
      command: ["sh","-c","echo 'this is nginx index page' > /set/index.html"]
      volumeMounts:
        - name: storage
          mountPath: /set
  containers:
  - image: nginx
    name: serve
    volumeMounts:
      - name: storage
        mountPath: /usr/share/nginx/html
    ports:
      - containerPort: 80
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  volumes:
    - name: storage
      emptyDir: {}
status: {}

# check pod ip with
k get po stew -o wide

# make request on port 80, it reflects changes from init container
wget -qO- <IP>
```
</p>
</details>