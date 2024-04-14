### create 3 pods named `one`, `two` and `three` with image `nginx:alpine` and label them `resource=alpha`, `resource=beta` and `resource=gama` respectively.
    
  <details><summary>Solution</summary>
  <p>

  ```bash
  k run one --image=nginx:alpine --labels=resource=alpha

  k run two --image=nginx:alpine --labels=resource=beta

  k run three --image=nginx:alpine --labels=resource=gama
  ```

  </p>
  </details>
