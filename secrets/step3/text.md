### create a `db` pod with image `mysql`, create a secret `mysqlcred` with following details:
- name: MYSQL_ROOT_PASSWORD
  value: "root_password"
- name: MYSQL_USER
  value: "username"
- name: MYSQL_PASSWORD
  value: "password"
- name: MYSQL_DATABASE
  value: "mydatabase"

### use this secret as environment variables from `db` pod.

<details><summary>Solution</summary>
  <p>

  ```bash
  # create the secret
  k create secret generic mysqlcred --from-literal=MYSQL_ROOT_PASSWORD=root_password --from-literal=MYSQL_USER=username --from-literal=MYSQL_PASSWORD=password --from-literal=MYSQL_DATABASE=mydatabase

  # set required env variables
  apiVersion: v1
  kind: Pod
  metadata:
    name: db
  spec:
    containers:
    - name: mysql
      image: mysql
      envFrom:
        - secretRef:
            name: mysqlcred

  #** the pod will fail don't worry about it, we need to run mysql command to keep it running. 
  ```

  </p>
</details>
