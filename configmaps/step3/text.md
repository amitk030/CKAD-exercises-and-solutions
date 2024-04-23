### create `gconfig` configmap with `ability=thunder`. Run a pod named `aries` with `nginx` image having env variable named `power` getting value from `ability` key of `gconfig` configmap.


<details><summary>Solution</summary>
  <p>

  ```bash
  # create configmap
  k create configmap gconfig --from-literal=ability=thunder

  # generate pod yaml file $dr(export dr="--dry-run=client -o yaml")
  k run aries --image=nginx $dr > pod.yaml

  # modify pod.yaml
  apiVersion: v1
  kind: Pod
  metadata:
    creationTimestamp: null
    labels:
      run: aries
    name: aries
  spec:
    containers:
    - image: nginx
      name: aries
      env:
        - name: power
          valueFrom:
            configMapKeyRef:
              name: gconfig
              key: ability
    dnsPolicy: ClusterFirst
    restartPolicy: Always
  status: {}

  # to check the env variable
  k exec aries -ti -- env
  ```

  </p>
</details>
