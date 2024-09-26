# Deployment Types

[Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
</br>

[Strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy)
[Canary Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#canary-deployment)
</br>

[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### create a deployment `nginx` with `nginx:1.18.0` image with `4` replicas, in the default namespace, with deployment strategy of `recreate` expose port `80` on the containers.

    <details><summary>Solution</summary>
      <p>

      ```bash
      #generate yaml file
      k create deploy nginx --image=nginx:1.18.0 --replicas=4 --dry-run=client -o yaml > deploy.yaml

      #update pod.yaml
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        creationTimestamp: null
        labels:
          app: nginx
        name: nginx
      spec:
        replicas: 4
        selector:
          matchLabels:
            app: nginx
        strategy:
          type: Recreate
        template:
          metadata:
            creationTimestamp: null
            labels:
              app: nginx
          spec:
            containers:
            - image: nginx:1.18.0
              name: nginx
              ports:
                - containerPort: 80
              resources: {}
      status: {}


      # create deployment
      k create -f deploy.yaml
      ```

      </p>
    </details>

1.  ### update existing deployment `nginx` in the default namespace, to change it's deployment strategy to `RollingUpdate` from `recreate` expose port `80` on the containers. And set maxSurge to `50%` while rolling update on the deployment

    #### you can delete the existing deployment & recreate it.

    <details><summary>Solution</summary>
      <p>

      ```bash
      #generate yaml file
      k create deploy nginx --image=nginx:1.18.0 --replicas=4 --dry-run=client -o yaml > deploy.yaml

      #update pod.yaml
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        creationTimestamp: null
        labels:
          app: nginx
        name: nginx
      spec:
        replicas: 4
        selector:
          matchLabels:
            app: nginx
        strategy:
          type: RollingUpdate
          rollingUpdate:
            maxSurge: 50%
        template:
          metadata:
            creationTimestamp: null
            labels:
              app: nginx
          spec:
            containers:
            - image: nginx:1.18.0
              name: nginx
              ports:
                - containerPort: 80
              resources: {}
      status: {}


      # create deployment
      k create -f deploy.yaml
      ```

      </p>
    </details>

1.  ### update `nginx` deployment to use image `nginx:1.19.8`. check deployment status running `k rollout status deploy nginx`. check no. of pods surge up to 6 while updation(check this by running `k get deploy nginx` )


    <details><summary>Solution</summary>
      <p>

      ```bash
      #update the deployment
      k edit deploy nginx 
      # then edit the container image
    
      OR

      # set new image on the deployment
      k set image deploy nginx nginx=nginx:1.19.8
      ```

      </p>
    </details>

1.  ### There exist a namespace `blue-green`, a deployment named `blue`. Also a service named `nginx-svc` exposing the `nginx` deployment on port `80`. If you request the service it will return `This is blue deployment`. Create another deployment named `green` with label `mark=green` & `image=nginx:1.19.8` and make changes such that it should return `This is green deployment` while calling `nginx-svc` service. Delete `blue` deployment.

    #### make request to the service now it should return `This is green deployment`.


    <details><summary>Setup</summary>
      <p>

      ```text
      # copy contents to a file 'script.sh'
      #!/bin/bash

      # Create the namespace
      kubectl create namespace blue-green

      # Create the deployment
      kubectl apply -f - <<EOF
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        creationTimestamp: null
        labels:
          app: nginx
        name: blue
        namespace: blue-green
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: nginx
        strategy: {}
        template:
          metadata:
            creationTimestamp: null
            labels:
              app: nginx
              mark: blue
          spec:
            initContainers:
              - image: busybox
                name: busybox
                command: ["sh","-c","echo 'This is blue deployment' > /sd/index.html"]
                volumeMounts:
                  - name: store
                    mountPath: /sd
            containers:
            - image: nginx:1.18.0
              name: nginx
              ports:
                - containerPort: 80
              volumeMounts:
                - name: store
                  mountPath: /usr/share/nginx/html
              resources: {}
            volumes:
              - name: store
                emptyDir: {}
      EOF

      kubectl expose deployment nginx --type=ClusterIP --name=nginx-svc --port=80 --target-port=80 --selector=mark=blue --namespace=blue-green
      echo "Namespace, service and deployment  created successfully."
      ```
      ```bash
        # make the file executable
        chmod +x script.sh

        # run script
        ./script.sh

        # make request to the svc
        # check service ip
        k get svc -n blue-green

        wget -qO- <IP>
      ```
      </p>
    </details>

    <details><summary>Solution</summary>
      <p>

      ```bash
      # update the deployment
        ...
        ...
        metadata:
          creationTimestamp: null
          labels:
            app: nginx
          name: blue
            ...
            ...
            labels:
              app: nginx
              mark: green
          spec:
            initContainers:
              - image: busybox
                name: busybox
                command: ["sh","-c","echo 'This is green deployment' > /sd/index.html"]
            ...
            ...
            containers:
              - image: nginx:1.19.8
                name: nginx
            ...
            ...

      # edit nginx-svc
      k edit svc nginx-svc
      # and update selector to mark: green
      ...
      selector:
        mark: green
      ...
      ```
      </p>
    </details>

1.  ### There exist a namespace `canary` with deployment `app-v1` and service `app-svc`.Make request to the service and it returns `App Version V1`. Create another deployment `app-v2` such that `50%` of traffic directed to it, after deploying `app-v2`. Making request to the service returns `App Version V1` if request goes to `app-v1` & and `App Version V2` if request goes to `app-v2`. use label `app=frontend`.


    <details><summary>Setup</summary>
      <p>

      ```text
      # copy contents to a file 'script.sh'
      #!/bin/bash

      # Create the namespace
      kubectl create namespace canary

      # Create the deployment
      kubectl apply -f - <<EOF
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        creationTimestamp: null
        labels:
          app: nginx
        name: app-v1
        namespace: canary
      spec:
        replicas: 2
        selector:
          matchLabels:
            app: frontend
        strategy: {}
        template:
          metadata:
            creationTimestamp: null
            labels:
              app: frontend
          spec:
            initContainers:
              - image: busybox
                name: busybox
                command: ["sh","-c","echo 'App Version V1' > /sd/index.html"]
                volumeMounts:
                  - name: store
                    mountPath: /sd
            containers:
            - image: nginx:1.18.0
              name: nginx
              ports:
                - containerPort: 80
              volumeMounts:
                - name: store
                  mountPath: /usr/share/nginx/html
              resources: {}
            volumes:
              - name: store
                emptyDir: {}
      EOF

      kubectl expose deployment app-v1 --type=ClusterIP --name=app-svc --port=80 --target-port=80 --selector=app=frontend --namespace=canary
      echo "Namespace, service and deployment  created successfully."
      ```
      ```bash
        # make the file executable
        chmod +x script.sh

        # run script
        ./script.sh

        # make request to the svc
        # check service ip
        k get svc -n canary

        wget -qO- <IP>
      ```
      </p>
    </details>

    <details><summary>Solution</summary>
      <p>

      ```bash
      # create deployment app-v2
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        creationTimestamp: null
        labels:
          app: nginx
        name: app-v2
        namespace: canary
      spec:
        replicas: 2
        selector:
          matchLabels:
            app: frontend
        strategy: {}
        template:
          metadata:
            creationTimestamp: null
            labels:
              app: frontend
          spec:
            initContainers:
              - image: busybox
                name: busybox
                command: ["sh","-c","echo 'App Version V2' > /sd/index.html"]
                volumeMounts:
                  - name: store
                    mountPath: /sd
            containers:
            - image: nginx:1.18.0
              name: nginx
              ports:
                - containerPort: 80
              volumeMounts:
                - name: store
                  mountPath: /usr/share/nginx/html
              resources: {}
            volumes:
              - name: store
                emptyDir: {}

      # make request to the svc
      # check service ip
      k get svc -n canary

      wget -qO- <IP>
      ```
      </p>
    </details>