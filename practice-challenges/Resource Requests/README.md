## Resource Requests

[Resource Requests](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### create a namespace `aarav` and create a pod with name `atharv` and `nginx` image, with the following requests `cpu=400m`, `memory=512Mi`. 

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create namespace
      k create ns aarav

      # k run atharv --image=nginx -n aarav --dry-run=client -o yaml > pod.yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: atharv
        name: atharv
        namespace: aarav
      spec:
        containers:
        - image: nginx
          name: atharv
          resources:
            requests:
              cpu: 400m
              memory: 512Mi
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}

      k create -f pod.yaml
      ```

      </p>
    </details>


1. ### create a namespace `omega` and create a pod with name `serve` and `nginx` image, with the following requests `cpu=400m`, `memory=512Mi` & limits `cpu=1`, `memory=1Gi`. 

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create namespace
      k create ns omega

      # k run serve --image=nginx -n omega --dry-run=client -o yaml > pod.yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: serve
        name: serve
        namespace: omega
      spec:
        containers:
        - image: nginx
          name: serve
          resources:
            requests:
              cpu: 400m
              memory: 512Mi
            limits:
              cpu: 1
              memory: 1Gi
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}

      k create -f pod.yaml
      ```

      </p>
    </details>
