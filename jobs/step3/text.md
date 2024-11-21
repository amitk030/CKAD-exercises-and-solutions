### Create a job named `retry-job` that retries on failure set it to `4` times.

<details><summary>Solution</summary>
  <p>

  ```bash
  kubectl apply -f - <<EOF
  apiVersion: batch/v1
  kind: Job
  metadata:
    name: retry-job
  spec:
    backoffLimit: 4
    template:
      spec:
        containers:
        - name: retry-container
          image: busybox
          command: ["sh", "-c", "exit 1"]
        restartPolicy: Never
  EOF
  ```
  </p>
</details>