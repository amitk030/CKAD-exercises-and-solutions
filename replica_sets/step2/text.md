### Create a replicaSet `rs1` with `replicas=3` and having pod template of `p1` pod.

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
