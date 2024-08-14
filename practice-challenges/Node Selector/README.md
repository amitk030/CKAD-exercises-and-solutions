# Node selector

[Node Selector](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/)
</br>
[Tips and Tricks](../../tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### Add label `name=master` to `controlplane` node. 
    <details><summary>Solution</summary>
      <p>

      ```bash
      k label node controlplane name=master
      ```
      </p>
    </details>

1.  ### create a pod named `p1` with `nginx` image. Schedule it on the `controlplane` node using node selector.
    
    <details><summary>Solution</summary>
      <p>

      ```bash
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: p1
        name: p1
      spec:
        nodeSelector:
          name: master
        containers:
        - image: nginx
          name: p1
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```

      </p>
    </details>

1.  ### Create a pod named `p2` with image `nginx`. Schedule it on the `controlplane` node using nodeName.
    <details><summary>Solution</summary>
      <p>

      ```bash
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: p1
        name: p1
      spec:
        nodeName: controlplane
        containers:
        - image: nginx
          name: p1
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```

      </p>
    </details>
