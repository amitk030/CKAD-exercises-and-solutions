### Create a namespace called `cygnus` and create a pod with name `alpha` and image `nginx` in this namespace.

<details><summary>Solution</summary>
<p>

```bash
kubectl create namespace cygnus
kubectl run alpha --image=nginx --restart=Never -n cygnus
```

</p>
</details>
