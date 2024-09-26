# Practice Problems Pods

[Read more about Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1. ### create `cygnus` namespace.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k create ns cygnus 
      ```

      </p>
    </details>

1.  ### create a yaml file for namespace `default`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k get ns default -o yaml > default-ns.yaml
      ```

      </p>
    </details>

1. ### create a pod with name `alpha` and image `nginx` in `cygnus` namespace.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k run alpha --image=nginx --restart=Never -n cygnus
      ```

      </p>
    </details>

1.  ### create a pod with name `theta` and image `nginx` in `default` namespace and write `env` variables of that pod to file `theta-env.txt`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k run theta --image=nginx
      k exec theta -ti -- env > theta-env.txt
      ```
      -- OR --

      ```bash
      k run theta --image=nginx -ti -- env # this will print env variables copy and paste it to theta-env.txt
      ```

      </p>
    </details>

1.  ### create a pod with name `beta` and image `nginx` and container name `bore`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k run beta --image=nginx --dry-run=client -o yaml > pod.yaml

      # update pod.yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: beta
        name: beta
      spec:
        containers:
        - image: nginx
          name: bore # update name here
          resources: {}
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      status: {}
      
      # create pod using this yaml file
      k create -f pod.yaml
      ```

      </p>
    </details>

1.  ### update image of pod created previously named `beta` to `nginx:1.6`

    <details><summary>Solution</summary>
      <p>

      ```bash
      k set image pod/beta bore=nginx:1.6
      ```

      </p>
    </details>

1.  ### list all the pods in all namespaces

    <details><summary>Solution</summary>
      <p>

      ```bash
      k get po -A # flag to get pods from all namespaces
      ```

      </p>
    </details>

1.  ### create a pod named `neon` and image `nginx` it runs `env` command and gets deleted after returning the environment variables.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k run neon --image=nginx -ti --rm -- env # --rm will delete the pod running env command
      ```

      </p>
    </details>

1.  ### create a `nginx` pod with name `delta`, expose container port 80 for this pod. Run a temporary `busybox` pod, to make `wget` request to `delta` pod at `\`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create delta pod
      k run delta --image=nginx --port=80

      # get ip of the delta pod
      k get po -o wide # this command will return ip details of the pod
      
      # create a temp busybox pod with
      k run temp --image=busybox -ti --rm -- sh

      # inside the shell run
      \# wget -qO- ip:80

      ```

      </p>
    </details>
