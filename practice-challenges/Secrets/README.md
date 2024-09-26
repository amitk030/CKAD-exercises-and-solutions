## Secrets

[Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### create a secret `mysecret` with `mypass=verysecret`. Decode the base64 incoded secret value after creation

    <details><summary>Solution</summary>
      <p>

      ```bash
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

1. ### create a secret `adminpass` from `admin.txt` with key `pass`

    ```bash
    echo "admin=password" > admin.txt
    ```

    <details><summary>Solution</summary>
      <p>

      ```bash
      k create secret generic adminpass --from-file=pass=admin.txt
      ```

      </p>
    </details>

1.  ### create a `db` pod with image `mysql`, create a secret `mysqlcred` with following details:
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

      #** the pod will fail don't worry about it we need to run mysql command to keep it running. 
      ```

      </p>
    </details>

1. ### create a secret named `source` with key value`app=v1`, run a `nginx` pod setting env variable`APP_VERSION` from value of `app` key in `source` secret. 

    <details><summary>Solution</summary>
      <p>

      ```bash
      k create secret generic source --from-literal=app=v1
      ```

      ```bash
      # generate pod yaml
      k run nginx --image=nginx --dry-run=client -o yaml > pod.yaml

      # add env to the pod yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: nginx
        name: nginx
      spec:
        containers:
        - image: nginx
          name: nginx
          resources: {}
          env:
            - name: APP_VERSION
              valueFrom:
                secretKeyRef:
                  name: source
                  key: app
        dnsPolicy: ClusterFirst
        restartPolicy: Always

      # create the pod
      k create -f pod.yaml
      ```

      </p>
    </details>

1. ### create a secret `dotfile-secret` with `hidden=value` run a `nginx` pod name `keeper`, mount secret as a volume named `secret-vol` at `/etc/secret` . 

    <details><summary>Solution</summary>
      <p>

      ```bash
      k create secret generic dotfile-secret --from-literal=hidden=value
      ```

      ```bash
      # generate pod yaml
      k run keeper --image=nginx --dry-run=client -o yaml > pod.yaml

      # add env to the pod yaml
      apiVersion: v1
      kind: Pod
      metadata:
        creationTimestamp: null
        labels:
          run: keeper
        name: keeper
      spec:
        volumes:
          - name: secret-vol
            secret:
              secretName: dotfile-secret
        containers:
        - image: nginx
          name: keeper
          resources: {}
          volumeMounts:
            - name: secret-vol
              mountPath: /etc/secret
        dnsPolicy: ClusterFirst
        restartPolicy: Always

      # create the pod
      k create -f pod.yaml

      # check volume mount
      k exec keeper -ti -- ls /etc/secret
      ```

      </p>
    </details>
