### Set horizontal autoscaling on the `nginx` deployment to have `min` of `5` pods and `max` of `10` pods.

<details><summary>Solution</summary>
<p>

```bash
#update the replicas
k autoscale deploy nginx --min=5 --max=10

# check the horizontal auto scaler
k get hpa nginx
```

</p>
</details>