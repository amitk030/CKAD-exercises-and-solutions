### create a namespace `pierre`. In this namespace create a limit range object named `memory-limit` for memory on containers, min to be `300Mi` and max to be `800Mi`. 

<details><summary>Solution</summary>
<p>

```bash
# create namespace
k create ns pierre

# create limit range: limitrange.yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: memory-limit
  namespace: pierre
spec:
  limits:
  - max: # max and min define the limit range
      memory: "800Mi"
    min:
      memory: "300Mi"
    type: Container

k create -f limitrange.yaml
```

</p>
</details>