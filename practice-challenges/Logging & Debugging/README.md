## Logging & Debugging

[Logging & Debugging](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_logs/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### create a namespace `distro`.Run a `busybox` pod name `bbox` with command `i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done` in `distro` namespace. Tails logs of the pod. 
    <details><summary>Solution</summary>
      <p>

      ```bash
      # create the namespace
      k create ns distro

      # create pod with the specified command
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: bbox
        name: bbox
        namespace: distro
      spec:
        containers:
        - image: busybox
          name: bbox
          command: ["sh","-c","i=0; while true; do echo '$i: $(date)'; i=$((i+1)); sleep 1; done"]
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}

      # tail the logs
      k logs bbox -n distro -t
      ```
      </p>
    </details>

1.  ### Create a `bitto` pod with `busybox` image. It runs a command `ls \here`. Check if the pod is running successfully, if not check why it's not running & then delete it. 
    <details><summary>Solution</summary>
      <p>

      ```bash
      # create the namespace
      k create ns nano

      # create pod with the specified command
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: bitto
        name: bitto
      spec:
        containers:
        - image: busybox
          name: bitto
          command: ["sh","-c","ls /here"]
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}

      # check details of the pod
      k describe po bitto
      ```
      </p>
    </details>