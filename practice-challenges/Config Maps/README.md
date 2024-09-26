# Config Map

[Config Map](https://kubernetes.io/docs/concepts/configuration/configmap/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)


##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### Create a config map `myconfig` with `var1=val1`

    <details><summary>Solution</summary>
      <p>

      ```bash
      k create configmap myconfig --from-literal=var1=val1
      ```

      </p>
    </details>

1. ### Create a config map `fileconfig` from a file created below, with `userdetails` key.
  
    ```bash
      echo "username=admin" > user.txt
    ```

    <details><summary>Solution</summary>
      <p>

      ```bash
      k create configmap fileconfig --from-file=userdetails=user.txt
      ```

      </p>
    </details>



1. ### create `gconfig` configmap with `ability=thunder`. Run a pod named `aries` with `nginx` image having env variable named `power` getting value from `ability` key of `gconfig` configmap.


    <details><summary>Solution</summary>
      <p>

      ```bash
      # create configmap
      k create configmap gconfig --from-literal=ability=thunder

      # generate pod yaml file $dr(export dr="--dry-run=client -o yaml")
      k run aries --image=nginx $dr > pod.yaml

      # modify pod.yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: aries
        name: aries
      spec:
        containers:
        - image: nginx
          name: aries
          env:
            - name: power
              valueFrom:
                configMapKeyRef:
                  name: gconfig
                  key: ability
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}

      # to check the env variable
      k exec aries -ti -- env
      ```

      </p>
    </details>


1. ### create `tconfig` configmap with `var9=val9`. Run a pod named `tarz` with `nginx` image having mounting `tconfig` as a volume at path `/delta` and name `core`. Do all these in `taurus` namespace.


    <details><summary>Solution</summary>
      <p>

      ```bash
      # create the ns
      k create ns taurus
      
      # set it as default namespace
      k config set-context --current --namespace=taurus

      # create configmap
      k create configmap tconfig --from-literal=var9=val9

      # generate pod yaml file $dr(export dr="--dry-run=client -o yaml")
      k run tarz --image=nginx $dr > pod.yaml

      # modify pod.yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: tarz
        name: tarz
      spec:
        volumes:
          - name: core
            configMap:
              name: tconfig
        containers:
        - image: nginx
          name: tarz
          volumeMounts:
            - name: core
              mountPath: /delta
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```

      </p>
    </details>
