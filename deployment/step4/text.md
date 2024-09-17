### Update replicas on `nginx` deployment to `5`.

<details><summary>Solution</summary>
<p>

```bash
#update the replicas
k scale deploy nginx --replicas=5

OR

# edit the deploy & set the replicas
k edit deploy nginx 
```

</p>
</details>