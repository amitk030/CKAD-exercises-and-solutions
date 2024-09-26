# Labels and Selectors

[Labels and Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### name a pod `sumo` with image `nginx` and label it `tier=frontend`
    <details><summary>Solution</summary>
      <p>

      ```bash
      k run sumo --image=nginx --labels=tier=frontend
      ```

      --OR--

      ```bash
      # update metadata of pod yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels: # add label
          tier: frontend
        name: sumo
      spec:
        containers:
        - image: nginx
          name: sumo
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```

      verify labels on pods running
      ```bash
        k get po --show-labels
      ```
      </p>
    </details>

1.  ### create 3 pods named `one`, `two` and `three` with image `nginx:alpine` and label them `resource=alpha`, `resource=beta` and `resource=gama` respectively.
    
    <details><summary>Solution</summary>
      <p>

      ```bash
      k run one --image=nginx:alpine --labels=resource=alpha

      k run two --image=nginx:alpine --labels=resource=beta

      k run three --image=nginx:alpine --labels=resource=gama
      ```

      </p>
    </details>

1.  ### Add label `tier=backend` to pods `one`,`two` and `three`
    <details><summary>Solution</summary>
      <p>

      ```bash
      k label pod one two three tier=backend
      ```

      </p>
    </details>

1.  ### Add label `app_version=v1` to pods having labels `tier=frontend` or `tier=backend`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k label pod -l "tier in (frontend,backend)" app_version=v1
      ```

      </p>
    </details>

1. ### Update label `app_version=v2` on pod `two`

    <details><summary>Solution</summary>
      <p>

      ```bash
      k label pod two app_version=v2 --overwrite
      ```

      </p>
    </details>

1. ### Remove label `app_version` on pod `one`

    <details><summary>Solution</summary>
      <p>

      ```bash
      k label pod one app_version-
      ```

      </p>
    </details>
