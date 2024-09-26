# Replica Sets

[Learn about replica sets](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### Run a pod `p1` with image `nginx` and label `tier=frontend`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k run p1 --image=nginx --labels=tier=frontend
      ```

      </p>
    </details>

1. ### Create a replicaSet `rs1` with `replicas=3` and having pod template of `p1` pod.

    <details><summary>Solution</summary>
      <p>

      replica_set.yaml
      ```bash
      apiVersion: apps/v1
      kind: ReplicaSet
      metadata:
        name: rs1
        labels:
          tier: frontend
      spec:
        replicas: 3 # no of pods
        selector:
          matchLabels:
            tier: frontend
        template: # pod p1 template details
          metadata:
            labels:
              tier: frontend
          spec:
            containers:
            - image: nginx
              name: p1
            dnsPolicy: ClusterFirst
            restartPolicy: Always
      ```
      </p>
    </details>

1. ### Delete two of pods belonging to `rs1` replicaSet, check the pods again they are reinstated to a total of `3`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # check the pods belonging to rs1 replica set
      #one is p1 that we created in the first step, other two will be named in pattern rs1-xxxxx
      k get po

      k delete po p1 rs1-xxx --force

      # list the pods
      # you will notice that the no of pods belonging to rs1 replica set are respawing, till they are 3 in number
      k get po
      ```

      </p>
    </details>
