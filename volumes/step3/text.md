### Run pod `pd-1808` with image `nginx:alpine` in namespace `ns-1808` mounting pvc `pvc-1808` as volume named `mydata` at mount path `/tedi`, run a command `echo "It feels awesome to prepare for CKAD" > /tedi/author.txt`. And it should run on `controlplane` node

  - check nodeName: controlplane

<details><summary>Solution</summary>
  <p>

  ```bash
  export do="--dry-run=client -o yaml"

  # generate pod.yaml
  k run pd-1808 --image=nginx:alpine $do > pod.yaml

  # update pod.yaml
  apiVersion: v1
  kind: Pod
  metadata:
    creationTimestamp: null
    labels:
      run: pd-1808
    name: pd-1808
    namespace: ns-1808
  spec:
    nodeName: controlplane
    volumes:
      - name: mydata
        persistentVolumeClaim:
          claimName: pvc-1808
    containers:
    - image: nginx:alpine
      name: pd-1808
      command: ["sh","-c","echo 'It feels awesome to prepare for CKAD' > /tedi/author.txt"]
      volumeMounts:
        - name: mydata
          mountPath: /tedi
    dnsPolicy: ClusterFirst
    restartPolicy: Always

  # now to verify that our text is persisted on the host storage
  # check node on which pod is scheduled
  k describe po pd-1808 -n ns-1808 | grep -i node

  # ssh to that node
  ssh <node-name>

  # check file contents
  cat /data/author.txt
  ```

  </p>
</details>
