### Their exist a pod `tasker` with `nginx` image. Check it's failure and fix it. You can delete & recreate the pod if needed.

<details><summary>Solution</summary>
  <p>

  ```bash
  # issue is with the port on which readiness probe is trying to connect

  # current pod
  apiVersion: v1
  kind: Pod
  metadata:
    name: tasker
  spec:
    containers:
    - name: nginx
      image: nginx
      ports:
      - containerPort: 80
      readinessProbe:
        httpGet:
          path: /
          port: 8080 # issue here to readiness probe, change it to 80
        initialDelaySeconds: 5
        periodSeconds: 10

  ```
  </p>
</details>