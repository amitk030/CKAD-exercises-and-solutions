### create pod `beta` and image `nginx` and store it's `env` in `beta-env.txt` file in `default` namespace.

<details><summary>Solution</summary>
<p>

```bash
k run beta --image=nginx

# after checking the pod started running successfully
k get po

# write env to the file
k exec beta -ti -- env > beta-env.txt
```

</p>
</details>
