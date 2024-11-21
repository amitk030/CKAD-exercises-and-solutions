### Create a job named `simple-job` that write's `Hello Kubernetes`

<details><summary>Solution</summary>
  <p>

  ```bash
  kubectl create job simple-job --image=busybox -- echo "Hello, Kubernetes!"
  ```
  </p>
</details>