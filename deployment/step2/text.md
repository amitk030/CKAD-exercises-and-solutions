### update the `nginx` deployment to use image `nginx:1.19.8`.

<details><summary>Solution</summary>
  <p>

  ```bash
  #update the deployment
  k edit deploy nginx
  # then edit the container image

  OR

  # set new image on the deployment
  k set image deploy nginx nginx=nginx:1.19.8
  ```

  </p>
</details>