### Create a job `parallel-job` with parallelism of `3` and completions of `3` that runs a busybox container. The command you can pass can be anything for example`echo Hello from the Kubernetes Job`. 

<details><summary>Solution</summary>
  <p>

  ```bash
  kubectl apply -f - <<EOF
  apiVersion: batch/v1
  kind: Job
  metadata:
    name: parallel-job
  spec:
    parallelism: 3
    completions: 3
    template:
      spec:
        containers:
        - name: parallel-container
          image: busybox
          command: ["sh", "-c", "echo Hello from the Kubernetes Job"]
        restartPolicy: Never
  EOF
  ```
  </p>
</details>