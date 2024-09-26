# Environment Variable

[Read about Environment Variables](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)
</br>
[Imperative commands for env variables](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_set/kubectl_set_env/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### create a pod `mypod` with image `nginx` containing two environment variables `env1=value1` and `env2=value2` .
    
    <details><summary>Solution</summary>
      <p>

      ```bash
      #generate yaml file
      k run mypod --image=nginx --dry-run=client -o yaml > pod.yaml

      #update pod.yaml
      apiVersion: v1
      kind: Pod
      metadata:
        labels:
          run: mypod
        name: mypod
      spec:
        containers:
        - image: nginx
          name: mypod
          resources: {}
          env:
            - name: env1
              value: "value1"
            - name: env2
              value: "value2"
        dnsPolicy: ClusterFirst
        restartPolicy: Always


      # create the pod
      k create -f pod.yaml
      ```

      </p>
    </details>

1.  ### write env variables of `mypod` to `mypod-env.txt` and check `env1=value1` and `env2=value2` environment variables are present.
    
    <details><summary>Solution</summary>
      <p>

      ```bash
      # write env to a file
      k exec mypod -ti -- env > mypod-env.txt

      # print env variables
      cat mypod-env.txt
      # env1 and env2 must be present
      ```

      </p>
    </details>

1.  ### create a `nginx` pod with image `nginx` and port is defined by `NGINX_PORT` to `8080`.
    
    <details><summary>Solution</summary>
      <p>

      ```bash
      # create pod yaml file
      k run nginx --image=nginx --dry-run=client -o yaml > nginx.yaml

      # update nginx port to 8080 using env variable
      apiVersion: v1
      kind: Pod
      metadata:
        labels:
          run: nginx
        name: nginx
      spec:
        containers:
        - image: nginx
          name: nginx
          resources: {}
          env:
            - name: NGINX_PORT
              value: "8080"
        dnsPolicy: ClusterFirst
        restartPolicy: Always
      ```

      </p>
    </details>

1.  ### create a `db` pod with image `mysql`, set the following env variables
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


