### create a secret `mysecret` with `mypass=verysecret`.

<details><summary>Solution</summary>
  <p>

  ```bash
  # create secret
  k create secret generic mysecret --from-literal=mypass=verysecret

  # check secret
  k get secret mysecret -o yaml
  #returns
  apiVersion: v1
  data:
    mypass: dmVyeXNlY3JldA==
  kind: Secret
  metadata:
    creationTimestamp: "2024-04-24T13:32:16Z"
    name: userpass
    namespace: default
    resourceVersion: "2040"
    uid: 8b80697b-1630-4288-adf6-a2ebd2bf3ec3

  # decode mypass value
  echo "dmVyeXNlY3JldA==" | base64 -d
  ```

  </p>
</details>
