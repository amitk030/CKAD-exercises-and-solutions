# Challenge 2

It's a 2-Node Kubernetes cluster, which is broken! Troubleshoot, fix the cluster issues and then deploy the objects according to the given architecture diagram to unlock our `Image Gallery`!!  Find the lab [here](https://kodekloud.com/topic/kubernetes-challenge-2/)

We work on building the solution by moving into the direction of the arrows in the diagram.
You can run check anytime while building the solution.

1.  <details>
    <summary>controlplane</summary>

    If we run any kubectl command we can see that it's making call on port 6433, we need to fix that to port 6443.

    1.  <details>
        <summary>kubeconfig = <code>/root/.kube/config</code>, User = <code>kubernetes-admin</code> Cluster: Server Port = <code>6443</code></summary>

        </br>Before we can execute any `kubectl` commands, we must fix the kubeconfig. The server port is incorrect and should be `6443`. Edit this in `vi` and save.

        ```bash
        vi .kube/config
        ```

        Change the following line to have the correct port `6443`, save and exit vi.

        ```yaml
            server: https://controlplane:6433
        ```

        After fixing this we can see that the error is different, like the server is not there. when we run `crictl ps` we can see that
        kube-apiserver is not running
        </details>

    1.  <details>
        <summary>Fix kube-apiserver. Make sure its running and healthy.</summary>

        </br>The file referenced by the `--client-ca-file` argument to the API server doesn't exist. Edit the API server manifest and correct this.

        ```bash
        ls -l /etc/kubernetes/pki/*.crt
        # Notice that the correct certificate is ca.crt
        vi /etc/kubernetes/manifests/kube-apiserver.yaml
        ```

        Change the following line to refer to the correct certificate file, save and exit vi.

        ```yaml
            - --client-ca-file=/etc/kubernetes/pki/ca-authority.crt
        ```

        Now wait for the API server to restart. This may take a minute or so. You can run the following to check if the container has been created. Press `CTRL-C` to escape from the following command.

        ```bash
        watch crictl ps
        ```

        If it still hasn't started, then give it a nudge by restarting the kubelet.

        ```bash
        systemctl restart kubelet
        ```

        ...then run the crictl command again. If you see it starting and stopping, then you've made an error in the manifest that you need to fix.

        now check any `kubectl` command. It should work now.
        </details>

    1.  <details>
        <summary>Master node: coredns deployment has image: <code>registry.k8s.io/coredns/coredns:v1.8.6</code></summary>

        </br>Run the following:

        ```bash
        kubectl get pods -n kube-system
        ```

        You will see that CoreDNS has ImagePull errors, because the container image is incorrect. To fix this, run the following, update the `image:` to that specificed in the question, save and exit

        ```bash
        kubectl edit deployment -n kube-system coredns
        ```

        ---- OR ----

        Edit the image directly

        ```bash
        kubectl set image deployment/coredns -n kube-system \
            coredns=registry.k8s.io/coredns/coredns:v1.8.6
        ```

        Now re-run the `get pods` command above (or use `watch` with it) until the coredns pods have recycled and there are two healthy pods.
        </details>
    </details>

1.  <details>
    <summary>node01</summary>

    </br>node01 is ready and can schedule pods? Run the following:

    ```bash
    kubectl get nodes
    ```

    We can see that `node01` is in state `Ready,SchedulingDisabled`. This usually means that it is cordoned, so...

    Read more on node adminstration(cordon) read: [Manual Node Adminstration](https://kubernetes.io/docs/concepts/architecture/nodes/#manual-node-administration)

    ```bash
    kubectl uncordon node01
    ```

    </details>

1.  <details>
    <summary>web</summary>

    </br>Copy all images from the directory '/media' on the controlplane node to '/web' directory on node01. Here we are setting up the content of the directory on `node01` which will ultimately be served as a hostpath persistent volume. It's a straght forward copy with ssh (scp).

    ```bash
    scp /media/* node01:/web
    ```

    </details>

1.  <details>
    <summary>data-pv</summary>

    <br>Create new PersistentVolume = 'data-pv'.</br>Apply the [manifest](./data-pv.yaml) with `kubectl create -f`

    </details>

1.  <details>
    <summary>data-pvc</summary>

    <br>Create new PersistentVolumeClaim = 'data-pvc'</br>Apply the [manifest](./data-pvc.yaml)

    </details>

1.  <details>
    <summary>gop-file-server</summary>

    <br>Create a pod for file server, name: 'gop-file-server'</br>Apply the [manifest](./gop-file-server-pod.yaml)

    </details>

1.  <details>
    <summary>gop-fs-service</summary>

    <br>New Service, name: 'gop-fs-service'</br>Apply the [manifest](./gop-fs-svc.yaml)

    </details>

