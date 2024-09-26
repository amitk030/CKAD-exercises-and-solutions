## Service Account

[Service Account](https://kubernetes.io/docs/concepts/security/service-accounts/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1. ### create a service account `sacc`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k create sa sacc
      ```

      </p>
    </details>

1. ### create a `pi` pod with `nginx` image using `sacc` as the service account.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # generate required pod yaml
      k run pi --image=nginx --dry-run=client -o yaml > pod.yaml

      # add service account name
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: pi
        name: pi
      spec:
        serviceAccountName: sacc
        containers:
        - image: nginx
          name: pi
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      ```

      </p>
    </details>
