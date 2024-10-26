### create a user `ardino`. The certificate and key are provided `user.crt` & `user.key`.


<details><summary>Solution</summary>
  <p>

  ```bash

  # create user
  k config set-credentials ardino --client-certificate=user.crt --client-key=user.key
  ```

  </p>
</details>
