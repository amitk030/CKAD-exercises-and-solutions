### Create a config map `fileconfig` from a file `user.txt`, with `userdetails` key.

<details><summary>Solution</summary>
  <p>

  ```bash
  k create configmap fileconfig --from-file=userdetails=user.txt
  ```

  </p>
</details>
