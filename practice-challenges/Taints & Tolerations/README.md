## Taints & Tolerations

[Taints & Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1. ### Taint `node01` with `reserved=space:NoSchedule`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k taint nodes node01 reserved=space:NoSchedule
      ```

      </p>
    </details>

1. ### schedule a pod with image `nginx` and name `bouncer`. Add tolerations to the pod for the following taint: `reserved=space:NoSchedule`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # generate required pod yaml
      k run bouncer --image=nginx --dry-run=client -o yaml > pod.yaml

      # add service account name
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: bouncer
        name: bouncer
      spec:
        tolerations:
          - key: "reserved"
            operator: "Equal"
            value: "space"
            effect: "NoSchedule"
        containers:
        - image: nginx
          name: bouncer
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      ```

      </p>
    </details>

1. ### Remove Taint `reserved=space:NoSchedule` from `node01`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k taint nodes node01 reserved=space:NoSchedule-
      ```

      </p>
    </details>
