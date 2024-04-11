### create pod `beta` and image `nginx` and store it's `env` in `beta-env.txt` file.

<details><summary>Solution</summary>
<p>

```bash
k run beta --image=nginx -ti -- env > beta-env.txt
```

</p>
</details>
