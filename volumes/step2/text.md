### Create a persistent Volume claim name `pvc-1808` in namespace `ns-1808`, binding to `pv-1808` with the following details:
  - storageClassName: ""
  - capacity.storage: 1Gi
  - volumeModes: Filesystem
  - accessModes: ReadWriteMany


<details><summary>Solution</summary>
  <p>

  ```bash
  # check for ns-1808 namespace
  k get ns
  # if it does not exist create it
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
