## Node Affinity

[Node Affinity](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### Label node `node01` with `scheduleNodes=true` . 
    <details><summary>Solution</summary>
      <p>

      ```bash
      k label node node01 scheduleNodes=true
      ```
      </p>
    </details>

1.  ### create a pod named `pod1` with `nginx` image. Schedule it on the `node01` node using `requiredDuringSchedulingIgnoredDuringExecution` node affinity.
    
    <details><summary>Solution</summary>
      <p>

      ```bash
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: pod1
        name: pod1
      spec:
        affinity:
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: scheduleNodes
                  operator: In
                  values:
                  - true
        containers:
        - image: nginx
          name: pod1
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```

      </p>
    </details>