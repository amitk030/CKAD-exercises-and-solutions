# Liveness & Readiness Probe

[Liveness & Readiness Probe](https://kubernetes.io/docs/concepts/configuration/liveness-readiness-startup-probes/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### create a pod `vids` with image `nginx`. Add a readiness probe to the container to exec `ls` command on it. 
    <details><summary>Solution</summary>
      <p>
      ```bash
      # generate pod yaml
      k run vids --image=nginx --dry-run=client -o yaml > pod.yaml

      # update metadata of pod yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: vids
        name: vids
      spec:
        containers:
        - image: nginx
          name: vids
          readinessProbe:
            exec:
              command:
                - ls
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```
      </p>
    </details>

1.  ### create a pod `aided` with image `nginx` expose port `80` on the container. Add a readiness probe to make http get request on port 80. 
    <details><summary>Solution</summary>
      <p>
      ```bash
      # generate pod yaml
      k run aided --image=nginx --dry-run=client -o yaml

      # update metadata of pod yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: aided
        name: aided
      spec:
        containers:
        - image: nginx
          name: aided
          ports:
            - containerPort: 80
          readinessProbe:
            httpGet:
              path: /
              port: 80
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```
      </p>
    </details>

1.  ### create a pod `baldr` with image `busybox` execute `sleep 3600` command on the container. Add a liveness probe to execute command `env` & add initial delay of `5` seconds to it.
    <details><summary>Solution</summary>
      <p>
      ```bash
      # generate pod yaml
      k run baldr --image=busybox --dry-run=client -o yaml > pod.yaml

      # update metadata of pod yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: baldr
        name: baldr
      spec:
        containers:
        - image: busybox
          name: baldr
          command: ["sh","-c","sleep 3600"]
          livenessProbe:
            exec:
              command:
                - env
            initialDelaySeconds: 5
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```
      </p>
    </details>

1.  ### create a pod `frigg` with image `nginx` expose port `80` on the container. Add a liveness probe on container with initial delay of `5`seconds & at a period of `3` seconds with failure threshold set to `8`. 
    <details><summary>Solution</summary>
      <p>
      ```bash
      # generate pod yaml
      k run frigg --image=nginx --dry-run=client -o yaml > pod.yaml

      # update metadata of pod yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: frigg
        name: frigg
      spec:
        containers:
        - image: nginx
          name: frigg
          ports:
            - containerPort: 80
          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 3
            failureThreshold: 8
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      ```
      </p>
    </details>