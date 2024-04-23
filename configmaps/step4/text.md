### create `tconfig` configmap with `var9=val9`. Run a pod named `tarz` with `nginx` image having mounting `tconfig` as a volume at path `/delta` and name `core`. Do all these in `taurus` namespace.


<details><summary>Solution</summary>
  <p>

  ```bash
  # create the ns
  k create ns taurus
  
  # set it as default namespace
  k config set-context --current --namespace=taurus

  # create configmap
  k create configmap tconfig --from-literal=var9=val9

  # generate pod yaml file $dr(export dr="--dry-run=client -o yaml")
  k run tarz --image=nginx $dr > pod.yaml

  # modify pod.yaml
  apiVersion: v1
  kind: Pod
  metadata:
    creationTimestamp: null
    labels:
      run: tarz
    name: tarz
  spec:
    volumes:
      - name: core
        configMap:
          name: tconfig
    containers:
    - image: nginx
      name: tarz
      volumeMounts:
        - name: core
          mountPath: /delta
    dnsPolicy: ClusterFirst
    restartPolicy: Always
  status: {}
  ```

  </p>
</details>
