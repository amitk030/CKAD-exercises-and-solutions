# Persistent Volume and Persistent Volume Claim

[Persistent Volume and Persistent Volume Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
</br>
[Reserving a Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reserving-a-persistentvolume)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)


##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### Create a persistent Volume name `pv-1808` with the following details:
    - storageClassName: ""
    - capacity.storage: 1Gi
    - volumeModes: FileSystem
    - accessModes: ReadWriteMany
    - hostPath: /data

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create pv.yaml
      apiVersion: v1
      kind: PersistentVolume
      metadata:
        name: pv-1808
      spec:
        capacity:
          storage: 1Gi
        volumeMode: Filesystem
        accessModes:
          - ReadWriteMany
        persistentVolumeReclaimPolicy: Recycle
        storageClassName: ""
        hostPath:
          path: /data


      # create persistent volume
      k create -f pv.yaml
      ```

      </p>
    </details>

1. ### Create a persistent Volume claim name `pvc-1808` in namespace `ns-1808`, binding to `pv-1808` with the following details:
    - storageClassName: ""
    - capacity.storage: 1Gi
    - volumeModes: FileSystem
    - accessModes: ReadWriteMany


    <details><summary>Solution</summary>
      <p>

      ```bash
      # check for the ns-1808 namespace
      k get ns

      # create if it does not exist
      k create ns ns-1808

      # create pvc.yaml
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: pvc-1808
        namespace: ns-1808
      spec:
        accessModes:
          - ReadWriteMany
        volumeMode: Filesystem
        resources:
          requests:
            storage: 1Gi
        storageClassName: ""
        volumeName: pv-1808


      # create persistent volume
      k create -f pvc.yaml

      # check pvc status to be binded
      k get pvc -n ns-1808
      ```

      </p>
    </details>


1. ### Run pod `pd-1808` with image `nginx:alpine` in namespace `ns-1808` mounting pvc `pvc-1808` as volume named `mydata` at mount path `/tedi`, run a command `echo "It feels awsome to prepare for CKAD" > /tedi/author.txt`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      export dr="--dry-run=client -o yaml"

      # generate pod.yaml
      k run pd-1808 --image=nginx:alpine $dr > pod.yaml

      # update pod.yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: pd-1808
        name: pd-1808
        namespace: ns-1808
      spec:
        volumes:
          - name: mydata
            persistentVolumeClaim:
              claimName: pvc-1808
        containers:
        - image: nginx:alpine
          name: pd-1808
          command: ["sh","-c","echo 'It feels awsome to prepare for CKAD' > /tedi/author.txt"]
          volumeMounts:
            - name: mydata
              mountPath: /tedi
        dnsPolicy: ClusterFirst
        restartPolicy: Always

      # now to verify that our text is persisted on the host storage
      # check node on which pod is scheduled
      k describe po pd-1808 -n ns-1808 | grep -i node

      # ssh to that node
      ssh <node-name>

      # check file contents
      cat /data/author.txt
      ```

      </p>
    </details>

1. ### Create a persistent Volume name `lv-vol` with storage capacity `1Gi`, mounting at `/inventory` and accessModes `RWO`, bind it to a claim name `lv-vol-claim` and mount it on a `busybox` pod name `busy` running command `sleep 3600` in namespace `default`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create pv.yaml
      apiVersion: v1
      kind: PersistentVolume
      metadata:
        name: lv-vol
        namespace: default
      spec:
        capacity:
          storage: 1Gi
        volumeMode: Filesystem
        accessModes:
          - ReadWriteOnce
        persistentVolumeReclaimPolicy: Recycle
        hostPath:
          path: /inventory

      # create persistent volume claim
      k create -f pv.yaml

      # create pvc.yaml
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: lv-vol-claim
        namespace: default
      spec:
        accessModes:
          - ReadWriteOnce
        volumeMode: Filesystem
        resources:
          requests:
            storage: 1Gi
        volumeName: lv-vol


      # create persistent volume claim
      k create -f pvc.yaml


      # mount it to a pod
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: busy
        name: busy
        namespace: default
      spec:
        volumes:
          - name: data
            persistentVolumeClaim:
              claimName: lv-vol-claim
        containers:
        - image: busybox
          name: busy
          resources: {}
          command: ["sh","-c","sleep 3600"]
          volumeMounts:
            - name: data
              mountPath: /log
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      ```

      </p>
    </details>


1. ### create a `rare` pod with image `nginx:alpine` mounting an emptyDir volume called `pdata` at `/usr/share/data`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      export do="--dry-run=client -o yaml"

      # generate pod.yaml
      k run rare --image=nginx:alpine $dr > pod.yaml

      # update pod.yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: rare
        name: rare
      spec:
        volumes:
          - name: pdata
            emptyDir: {}
        containers:
        - image: nginx:alpine
          name: rare
          volumeMounts:
            - name: pdata
              mountPath: /usr/share/data
        dnsPolicy: ClusterFirst
        restartPolicy: Always

      # create the pod
      k create -f pod.yaml
      ```

      </p>
    </details>
