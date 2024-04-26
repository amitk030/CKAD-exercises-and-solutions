### Run an `nginx:alpine` pod with name `scorpion`, the ruinng container named `scorpion-container` should not have privilege escalation enabled.

<details><summary>Solution</summary>
  <p>

  ```bash
  # generate pod yaml
  k run scorpion --image=nginx:alpine $dr > pod.yaml

  # modify pod yaml
  apiVersion: v1
  kind: Pod
  metadata:
    creationTimestamp: null
    labels:
      run: scorpion
    name: scorpion
  spec:
    containers:
    - image: nginx:alpine
      name: scorpion-container
      securityContext:
        allowPrivilegeEscalation: false # add this security context for container
    dnsPolicy: ClusterFirst
    restartPolicy: Always

  # create the pod
  k create -f pod.yaml
  ```

  </p>
</details>
