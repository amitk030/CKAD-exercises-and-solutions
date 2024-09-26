## Security Context

[Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1. ### create a `busybox` pod, named `bi` in which security context for user is set as `500` and `800` for group. Run commad `sleep 3600` in the pod.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # generate pod yaml
      k run bi --image=busybox --dry-run=client -o yaml > pod.yaml

      # modify pod yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: bi
        name: bi
      spec:
        securityContext:
          runAsUser: 500
          runAsGroup: 800
        containers:
        - image: busybox
          name: bi
          command: ["sleep","3600"]
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always

      # create the pod
      k create -f pod.yaml

      # check security context values
      k exec bi -ti -- id
      ```

      </p>
    </details>


1. ### Run an `nginx:alpine` pod with name `scorpion`, the ruinng container should not have privilege escalation enabled.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # generate pod yaml
      k run scorpion --image=nginx:alpine $dr > pod.yaml

      # modify pod yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: scorpion
        name: scorpion
      spec:
        containers:
        - image: nginx:alpine
          name: scorpion
          securityContext:
            allowPrivilegeEscalation: false # add this security context for container
        dnsPolicy: ClusterFirst
        restartPolicy: Always

      # create the pod
      k create -f pod.yaml
      ```

      </p>
    </details>

1. ### Run an `nginx:alpine` pod with name `proc`, having `net admin` and `sys time` capabilities enabled.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # generate pod yaml
      k run proc --image=nginx:alpine $dr > pod.yaml

      # modify pod yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: proc
        name: proc
      spec:
        containers:
        - image: nginx:alpine
          name: proc
          securityContext:
            capabilities:
              add: ["SYS_TIME","NET_ADMIN"] # set the required capabilities
        dnsPolicy: ClusterFirst
        restartPolicy: Always

      # create the pod
      k create -f pod.yaml
      ```

      </p>
    </details>
