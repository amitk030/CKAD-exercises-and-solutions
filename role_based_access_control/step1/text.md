### create a role named `developer` which has can perform anything on `pods` & `services`. 

<details><summary>Solution</summary>
  <p>

  ```bash
  # file role.yaml
  apiVersion: rbac.authorization.k8s.io/v1
  kind: Role
  metadata:
    name: developer
  rules:
  - apiGroups: [""]
    resources: ["pods", "services"]
    verbs: ["*"]


  # using imperative command
  k create role developer --resource=pods,services --verb=*
  ```

  </p>
</details>