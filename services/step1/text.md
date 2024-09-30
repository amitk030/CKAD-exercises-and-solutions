### A `nginx` pod is deployed on node `node01` with container port exposed at `80` and label `app=myapp`. Create a NodePort service named `ng-svc` to expose `nginx` pod on node Port `30002`.

<details><summary>Solution</summary>
  <p>

  ```bash
  # create service yaml file
  k create svc nodeport ng-svc --tcp=80:80 --target-port=80 --dry-run=client -o yaml > service.yaml
  
  # update selector in service yaml file
  apiVersion: v1
  kind: Service
  metadata:
    creationTimestamp: null
    labels:
      app: ng-svc
    name: ng-svc
  spec:
    ports:
    - name: ports
      nodePort: 30002
      port: 80
      protocol: TCP
      targetPort: 80
    selector:
      app: myapp
    type: NodePort

  # create service
  k create -f service.yaml

  # get the node ip address
  k get nodes -o wide

  # make request on the node ip with port 30002
  wget -qO- <node01-ip>:30002
  ```

  </p>
</details>