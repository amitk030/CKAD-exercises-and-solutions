### There exist a ConfigMap `job-script` created from file `script.sh`. Create a job named `script-job` that runs the script from the ConfigMap.

<details><summary>Solution</summary>
  <p>

  ```bash
  # check configmap
  k get configmap job-script -o yaml

  # job.yaml
  kubectl apply -f - <<EOF
  apiVersion: batch/v1
  kind: Job
  metadata:
    name: script-job
  spec:
    template:
      spec:
        containers:
        - name: script
          image: busybox
          command: ["sh", "/scripts/script.sh"]
          volumeMounts:
          - name: script-volume
            mountPath: /scripts
        restartPolicy: Never
        volumes:
        - name: script-volume
          configMap:
            name: job-script
  EOF
  ```
  </p>
</details>