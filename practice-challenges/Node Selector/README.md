# Node selector

[Node Selector](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### Add label `name=master` to `node01` node. 
    <details><summary>Solution</summary>
      <p>

      ```bash
      k label node node01 name=master
      ```
      </p>
    </details>

1.  ### create a pod named `p1` with `nginx` image. Schedule it on the `node01` node using node selector.
    
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

1.  ### Create a pod named `p2` with image `nginx`. Schedule it on the `node01` node using nodeName.
    <details><summary>Solution</summary>
      <p>

      ```bash
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: p2
        name: p2
      spec:
        nodeName: node01
        containers:
        - image: nginx
          name: p2
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```

      </p>
    </details>
