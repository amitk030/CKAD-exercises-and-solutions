### Create a config map `myconfig` with `var1=val1`

<details><summary>Solution</summary>
  <p>

  ```bash
  k create configmap myconfig --from-literal=var1=val1
  ```

  </p>
</details>
