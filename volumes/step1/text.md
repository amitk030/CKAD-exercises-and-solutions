### Create a persistent Volume name `pv-1808` with the following details:
  - storageClassName: ""
  - capacity.storage: 1Gi
  - volumeModes: Filesystem
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
