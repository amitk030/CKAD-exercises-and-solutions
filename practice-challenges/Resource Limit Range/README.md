## Resource Limit Range

[Resource Limit Range](https://kubernetes.io/docs/concepts/policy/limit-range/)
</br>
[Tips and Tricks](../../tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### create a namespace `pierre`. In this namespace create a limit range object named `memory-limit` for memory on containers, min to be `300Mi` and max to be `800Mi`. 

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create namespace
      k create ns pierre

      # create limit range: limitrange.yaml
      apiVersion: v1
      kind: LimitRange
      metadata:
        name: memory-limit
        namespace: one
      spec:
        limits:
        - max: # max and min define the limit range
            memory: "800Mi"
          min:
            memory: "300Mi"
          type: Container

      k create -f limitrange.yaml
      ```

      </p>
    </details>


1. ### Try creating a pod `server` with `nginx` image in `pierre` namespace with resources request of `memory=500Mi`. The pod creation will fail, once you define limitrange you need to provie limit for that resource in that namespace.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create the server pod
      k run server --image=nginx --dry-run=client -o yaml > pod.yaml
      
      # update resources request and limits in the pod
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: server
        name: server
        namespace: pierre
      spec:
        containers:
        - image: nginx
          name: server
          resources:
            requests:
              memory: 500Mi
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      ```

      </p>
    </details>

1. ### Modify `server` pod in `pierre` namespace with resources limit of `memory=700Mi`. Verify that pod creation will succeed.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # delete the pod if it exists.
      k delete po server --force

      # update resources request and limits in the pod
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: server
        name: server
        namespace: pierre
      spec:
        containers:
        - image: nginx
          name: server
          resources:
            requests:
              memory: 500Mi
            limit:
              memory: 700Mi
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      ```

      </p>
    </details>
