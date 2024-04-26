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

      # check security context set on pod
      k exec bi -ti -- id
      ```

      </p>
    </details>
