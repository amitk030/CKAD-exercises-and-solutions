### create a pod `mypod` with image `nginx` containing two environment variables `env1=value1` and `env2=value2` .
    
<details><summary>Solution</summary>
  <p>

  ```bash
  #generate yaml file
  k run mypod --image=nginx --dry-run=client -o yaml > pod.yaml

  #update pod.yaml
  apiVersion: v1
  kind: Pod
  metadata:
    labels:
      run: mypod
    name: mypod
  spec:
    containers:
    - image: nginx
      name: mypod
      resources: {}
      env:
        - name: env1
          value: "value1"
        - name: env2
          value: "value2"
    dnsPolicy: ClusterFirst
    restartPolicy: Always


  # create the pod
  k create -f pod.yaml
  ```

  </p>
</details>
