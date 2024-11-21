### Create a CronJob named `eg-cron` that runs every minute and logs `Every minute CronJob`.

**Note:** verify atleast after one job is completed.

<details><summary>Solution</summary>
  <p>

  ```bash
  kubectl apply -f - <<EOF
  apiVersion: batch/v1
  kind: CronJob
  metadata:
    name: eg-cron
  spec:
    schedule: "* * * * *"
    jobTemplate:
      metadata:
        labels:
          job: eg-cron
      spec:
        template:
          spec:
            containers:
            - name: hello
              image: busybox
              command: ["sh", "-c", "echo  Every minute CronJob"]
            restartPolicy: OnFailure
  EOF
  ```
  </p>
</details>