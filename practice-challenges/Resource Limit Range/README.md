## Resource Limit Range

[Resource Limit Range](https://kubernetes.io/docs/concepts/policy/limit-range/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### create a namespace `pierre`. In this namespace create a limit range object named `memory-limit` for memory on containers, min to be `300Mi` and max to be `800Mi` & `cpu` to be between `600m` & `300m`. 

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
        namespace: pierre
      spec:
        limits:
        - max: # max and min define the limit range
            memory: "800Mi"
            cpu: 600m
          min:
            cpu: 300m
            memory: "300Mi"
          type: Container

      k create -f limitrange.yaml
      ```

      </p>
    </details>


1. ### Try creating a pod `server` with `nginx` image in `pierre` namespace with resources request of `cpu=700m`. The pod creation will fail, once you define limitrange you need to provie cpu limit if it exceeds the given range in that namespace.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create the server pod
      k run server --image=nginx --dry-run=client -o yaml > pod.yaml
      
      # pod file
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

1. ### Modify `server` pod in `pierre` namespace with resources limit of `cpu=700m`. Verify that pod creation will succeed.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # delete the pod if it exists.
      k delete po server --force

      # pod file
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
