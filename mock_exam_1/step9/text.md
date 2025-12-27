### Create a PersistentVolume named `pv-exam` with the following specifications:
- `storageClassName`: empty string
- `capacity.storage`: `2Gi`
- `volumeMode`: `Filesystem`
- `accessModes`: `ReadWriteOnce`
- `hostPath`: `/mnt/data`

Then create a PersistentVolumeClaim named `pvc-exam` in the `storage-ns` namespace that requests `1Gi` storage with `ReadWriteOnce` access mode. Finally, create a pod named `storage-pod` with image `nginx` that uses this PVC mounted at `/data`.

