### There exist a deployment named `backend` in `setup` namespace. Create a service `dep-svc` that expose the deployment on port `80`.

<details><summary>Solution</summary>
  <p>

  ```bash
  # expose deployment on port 80
   k expose deploy backend --name=dep-svc --type=ClusterIP --port=80 --namespace=setup
  ```

  </p>
</details>