### There exist a namespace `blue-green`, a deployment named `blue`. Also a service named `nginx-svc` exposing the `nginx` deployment on port `80`. If you request the service it will return `This is blue deployment`. Create another deployment named `green` with label `mark=green` & `image=nginx:1.19.8` and make changes such that it should return `This is green deployment` while calling `nginx-svc` service. Delete `blue` deployment.

    #### make request to the service now it should return `This is green deployment`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      # update the deployment
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