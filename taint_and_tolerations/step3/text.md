### Remove Taint `reserved=space:NoSchedule` from `node01`.

<details><summary>Solution</summary>
<p>

```bash
k taint nodes node01 reserved=space:NoSchedule-
```

</p>
</details>