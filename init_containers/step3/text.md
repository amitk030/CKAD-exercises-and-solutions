### Take `stew` pod created from `demeter` namespace, there exist a yaml file `pod.yaml` for reference & use. create a volume named `storage` in the `stew` pod of type `emptyDir`. Mount `storage` volume on initContainer at path `/set` and run a command in init container `echo "this is nginx index page" > /set/index.html`. Mount same volume in nginx container at path `/usr/share/nginx/html`. Do these updates in `pod.yaml`. Delete & create the pod again

<details><summary>Solution</summary>
<p>

```bash
# generate your own yaml file to edit with
k get po stew -n demeter -o yaml > pod.yaml


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
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  volumes:
    - name: storage
      emptyDir: {}
status: {}
```

</p>
</details>