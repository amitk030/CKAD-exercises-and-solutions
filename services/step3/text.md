### There exist a `bbox` pod in `setup` namespace. Expose pod on port `80`.

<details><summary>Solution</summary>
  <p>

  ```bash
  # create pod on port 80
   k expose pod bbox --port=80 --name=bbox-svc --namespace=setup
  ```

  </p>
</details>