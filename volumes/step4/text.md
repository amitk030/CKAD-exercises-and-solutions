### Create a persistent Volume name `lv-vol` with storage capacity `1Gi`, mounting at `/inventory` and accessModes `RWO`, bind it to a claim name `lv-vol-claim` and mount it on a `busybox` pod name `busy` running command `sleep 3600` in namespace `default`.

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
