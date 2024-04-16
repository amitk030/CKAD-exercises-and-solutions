### create a `db` pod with image `mysql`, set the following env variables
  - name: MYSQL_ROOT_PASSWORD
    value: "root_password"
  - name: MYSQL_USER
    value: "username"
  - name: MYSQL_PASSWORD
    value: "password"
  - name: MYSQL_DATABASE
    value: "mydatabase"
    
<details><summary>Solution</summary>
  <p>

  ```bash
  # create pod yaml file
  k run db --image=mysql --dry-run=client -o yaml > db.yaml

  # set required env variables
  apiVersion: v1
  kind: Pod
  metadata:
    name: db
  spec:
    containers:
    - name: mysql
      image: mysql
      env:
      - name: MYSQL_ROOT_PASSWORD
        value: "root_password"
      - name: MYSQL_USER
        value: "username"
      - name: MYSQL_PASSWORD
        value: "password"
      - name: MYSQL_DATABASE
        value: "mydatabase"
  ```

  </p>
</details>
