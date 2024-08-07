## Modify `server` pod with resources request of `cpu=1` and `memory=1Gi`. You can delete and create the pod again. Check, now the pod will start running.

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