# Jobs

[Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
</br>

[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### Create a namespace `kam`.
    <details><summary>Solution</summary>
      <p>

      ```bash
      k create ns kam
      ```
      </p>
    </details>

1. ### Create a job named `simple-job` that write's `Hello Kubernetes` to file `job-output.txt`
    <details><summary>Solution</summary>
      <p>

      ```bash
      kubectl create job simple-job --image=busybox -- echo "Hello, Kubernetes!"
      ```
      </p>
    </details>

2. ### Create a job that runs a script from a ConfigMap
    <details><summary>Solution</summary>
      <p>

      ```bash
      kubectl create configmap job-script --from-file=script.sh
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

3. ### Create a job that retries on failure
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

4. ### Create a job with parallelism
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

5. ### Create a CronJob that runs every minute
    <details><summary>Solution</summary>
      <p>

      ```bash
      kubectl apply -f - <<EOF
      apiVersion: batch/v1
      kind: CronJob
      metadata:
        name: hello-cron
      spec:
        schedule: "*/1 * * * *"
        jobTemplate:
          spec:
            template:
              spec:
                containers:
                - name: hello
                  image: busybox
                  command: ["sh", "-c", "date; echo Hello from the Kubernetes CronJob"]
                restartPolicy: OnFailure
      EOF
      ```
      </p>
    </details>
