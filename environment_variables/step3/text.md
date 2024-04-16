### create a `nginx` pod with image `nginx` and port is defined by `NGINX_PORT` to `8080`.
    
<details><summary>Solution</summary>
  <p>

  ```bash
  # create pod yaml file
  k run nginx --image=nginx --dry-run=client -o yaml > nginx.yaml

  # update nginx port to 8080 using env variable
  apiVersion: v1
  kind: Pod
  metadata:
    labels:
      run: nginx
    name: nginx
  spec:
    containers:
    - image: nginx
      name: nginx
      resources: {}
      env:
        - name: NGINX_PORT
          value: "8080"
    dnsPolicy: ClusterFirst
    restartPolicy: Always
  ```

  </p>
</details>
