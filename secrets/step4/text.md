### create a secret named `source` with key value`app=v1`, run a `nginx` pod setting env variable`APP_VERSION` from value of `app` key in `source` secret. 

<details><summary>Solution</summary>
  <p>

  ```bash
  k create secret generic source --from-literal=app=v1
  ```

  ```bash
  # generate pod yaml
  k run nginx --image=nginx --dry-run=client -o yaml > pod.yaml

  # add env to the pod yaml
  apiVersion: v1
  kind: Pod
  metadata:
    creationTimestamp: null
    labels:
      run: nginx
    name: nginx
  spec:
    containers:
    - image: nginx
      name: nginx
      resources: {}
      env:
        - name: APP_VERSION
          valueFrom:
            secretKeyRef:
              name: source
              key: app
    dnsPolicy: ClusterFirst
    restartPolicy: Always

  # create the pod
  k create -f pod.yaml
  ```

  </p>
</details>
