## Resource Quota

[Resource Quota](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### create a namespace `demo` and create a resource quota `demo-quota` with hard requests `cpu=1`, `memory=1Gi` and hard limits `cpu=2`, `memory=2Gi`. 

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create namespace
      k create ns demo

      # create resource quota > quota.yaml
      apiVersion: v1
      kind: ResourceQuota
      metadata:
        name: demo-quota
        namespace: demo
      spec:
        hard:
          requests.cpu: "1"
          requests.memory: 1Gi
          limits.cpu: "2"
          limits.memory: 2Gi

      k create -f quota.yaml

      k create quota demo-quota -n demo --hard=requests.cpu=1,requests.memory=1Gi,limits.cpu=2,limits.memory=2Gi 
      ```

      </p>
    </details>


1. ### Try creating a pod `server` with `nginx` image in `demo` namespace with resources request of `cpu=2.1` and `memory=2.5Gi`. The pod creation will fail

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create the server pod
      k run server --image=nginx --dry-run=client -o yaml > pod.yaml
      
      # update resources request and limits in the pod
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: server
        name: server
        namespace: demo
      spec:
        containers:
        - image: nginx
          name: server
          resources:
            requests:
              cpu: "2.1"
              memory: 2.5Gi
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      ```

      </p>
    </details>

1. ### Modify `server` pod with resources request of `cpu=1` and `memory=1Gi`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # delete the pod if it exists.
      k delete po server --force

      # update resources request and limits in the pod
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: server
        name: server
      spec:
        containers:
        - image: nginx
          name: server
          resources:
            requests:
              cpu: "1"
              memory: 1Gi
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      ```

      </p>
    </details>
