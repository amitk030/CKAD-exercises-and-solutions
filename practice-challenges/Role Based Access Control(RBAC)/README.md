## Role Based Access Control

[RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### create a role named `developer` which has can perform anything on `pods` & `services`. 

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

1. ### create a user `ardino`. The certificate and key are provided `user.crt` & `user.key`.

    <details><summary>Setup</summary>
      <p>

      ```bash
      
      # Step 1: Generate a private key and CSR
      openssl genrsa -out user.key 2048
      openssl req -new -key user.key -out user.csr -subj "/CN=user/O=users"

      # Step 2: Sign the CSR with the Kubernetes CA
      # Assuming the Kubernetes CA files are located at /etc/kubernetes/pki/
      openssl x509 -req -in user.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out user.crt -days 365

      ```
      </p>
    </details>

    <details><summary>Solution</summary>
      <p>

      ```bash

      # create user
      k config set-credentials ardino --client-certificate=user.crt --client-key=user.key
      ```

      </p>
    </details>


1. ### create a role binding `developer-rolebinding`.

    <details><summary>Solution</summary>
      <p>

      ```bash

      # create user
      k create rolebinding developer-rolebinding --user=ardino --role=developer
      ```

      </p>
    </details>


