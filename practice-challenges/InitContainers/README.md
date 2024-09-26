# Init Containers

[Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### Create a namespace `demeter`.
    <details><summary>Solution</summary>
      <p>

      ```bash
      k create ns demeter
      ```
      </p>
    </details>

1.  ### In `demeter` namespace create a pod named `stew` with an init container named `setup` with `busybox` image. Run another container named `serve` with `nginx` image.

    <details><summary>Solution</summary>
      <p>

      ```bash
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: stew
        name: stew
        namespace: demeter
      spec:
        initContainers:
          - image: busybox
            name: setup
        containers:
        - image: nginx
          name: serve
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```

      </p>
    </details>

1.  ### Take `stew` pod created from `demeter` namespace, there exist a yaml file `pod.yaml` for reference & use. create a volume named `storage` in the `stew` pod of type `emptyDir`. Mount `storage` volume on initContainer at path `/set` and run a command in init container `echo "this is nginx index page" > /set/index.html`. Mount same volume in nginx container at path `/usr/share/nginx/html`. Do these updates in `pod.yaml`. Delete & create the pod again

    <details><summary>Solution</summary>
      <p>

      ```bash
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: stew
        name: stew
        namespace: demeter
      spec:
        initContainers:
          - image: busybox
            name: setup
            command: ["sh","-c","echo 'this is nginx index page' > /set/index.html"]
            volumeMounts:
              - name: storage
                mountPath: /set
        containers:
        - image: nginx
          name: serve
          volumeMounts:
            - name: storage
              mountPath: /usr/share/nginx/html
        dnsPolicy: ClusterFirst
        restartPolicy: Always
        volumes:
          - name: storage
            emptyDir: {}
      status: {}
      ```

      </p>
    </details>

1. ### Take `stew` pod created from `demeter` namespace. Export port `80` of `nginx` container. 

    <details><summary>Solution</summary>
      <p>

      ```bash
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: stew
        name: stew
        namespace: demeter
      spec:
        initContainers:
          - image: busybox
            name: setup
            command: ["sh","-c","echo 'this is nginx index page' > /set/index.html"]
            volumeMounts:
              - name: storage
                mountPath: /set
        containers:
        - image: nginx
          name: serve
          volumeMounts:
            - name: storage
              mountPath: /usr/share/nginx/html
          ports:
            - containerPort: 80
        dnsPolicy: ClusterFirst
        restartPolicy: Always
        volumes:
          - name: storage
            emptyDir: {}
      status: {}
      ```

      </p>
    </details>

1. ### check IP of `stew` pod and request it at port `80`. Run a temporary `busybox` pod to perform that.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # check ip of the stew pod
      k get po stew -o wide

      # make request on port 80
      wget -qO- <IP>
      ```

      </p>
    </details>

