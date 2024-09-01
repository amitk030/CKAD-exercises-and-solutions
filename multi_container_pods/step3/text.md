### From the running `worker` pod in `nano` namespace, save `env` variables of busybox container to `busybox.txt` file.
    
<details><summary>Solution</summary>
<p>

```bash
# check for the running pod
k get po -n nano

# list the env of busybox container & save it to a file
k exec -ti worker -n nano -c busybox -- env

# or
k exec -ti worker -n nano -c busybox -- printenv > busybox.txt
```

</p>
</details>