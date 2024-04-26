### create a secret `dotfile-secret` with `hidden=value`, run a `nginx` pod name `keeper`, mount this secret as a volume named `secret-vol` at `/etc/secret`. 

<details><summary>Solution</summary>
  <p>

  ```bash
  k create secret generic dotfile-secret --from-literal=hidden=value
  ```

  ```bash
  # generate pod yaml
  k run keeper --image=nginx --dry-run=client -o yaml > pod.yaml

  # add env to the pod yaml
  apiVersion: v1
  kind: Pod
  metadata:
    creationTimestamp: null
    labels:
      run: keeper
    name: keeper
  spec:
    volumes:
      - name: secret-vol
        secret:
          secretName: dotfile-secret
    containers:
    - image: nginx
      name: keeper
      resources: {}
      volumeMounts:
        - name: secret-vol
          mountPath: /etc/secret
    dnsPolicy: ClusterFirst
    restartPolicy: Always

  # create the pod
  k create -f pod.yaml

  # check volume mount
  k exec keeper -ti -- ls /etc/secret
  ```

  </p>
</details>
