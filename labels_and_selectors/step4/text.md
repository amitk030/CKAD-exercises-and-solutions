### Add label `app_version=v1` to pods having labels `tier=frontend` or `tier=backend`.

<details><summary>Solution</summary>
  <p>

  ```bash
  k label pod -l "tier in (frontend,backend)" app_version=v1
  ```

  </p>
</details>
