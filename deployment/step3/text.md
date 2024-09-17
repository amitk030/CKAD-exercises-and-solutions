### Rollback image `nginx:1.19.8` update to `nginx:1.18.0` on the nginx deployment

<details><summary>Solution</summary>
<p>

```bash
#update the deployment
k rollout undo deploy nginx
# then edit the container image

OR

# set new image on the deployment
k set image deploy nginx nginx=nginx:1.18.0
```

</p>
</details>