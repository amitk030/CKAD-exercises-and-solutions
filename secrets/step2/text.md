### create a secret `admindetails` from `admin.txt` with key `pass`


<details><summary>Solution</summary>
  <p>

  ```bash
  k create secret generic admindetails --from-file=pass=admin.txt
  ```

  </p>
</details>
