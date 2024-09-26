## Multi Container Pods

[Multi Container Pods](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### create a namespace `nano`. 
    <details><summary>Solution</summary>
      <p>

      ```bash
      k create ns nano
      ```
      </p>
    </details>

1.  ### create a pod named `worker` in `nano` namespace. create two containers in it one with `nginx` image, and another with `busybox` image. In container with busybox image run bash command `sleep 3600`.
    
    <details><summary>Solution</summary>
      <p>

      ```bash
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: worker
        name: worker
      spec:
        containers:
        - image: nginx
          name: nginx
        - image: busybox
          name: busybox
          command: ["sh","-c","sleep 3600"]
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```

      </p>
    </details>

1.  ### From the running `worker` pod in `nano` namespace, save `env` variables of busybox container to `busybox.txt` file.
    
    <details><summary>Solution</summary>
      <p>

      ```bash
      # check for the running pod
      k get po -n nano

      # list the env of busybox container & save it to a file
      k exec -ti worker -n nano -c busybox -- env

      # or
      k exec -ti worker -n nano -c busybox -- printenv > busybox.txt
      ```

      </p>
    </details>