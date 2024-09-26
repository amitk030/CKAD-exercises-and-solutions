# Deployment

[Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
</br>
[Imperative commands for deployment](https://kubernetes.io/docs/reference/kubectl/quick-reference/#interacting-with-deployments-and-services)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### create a deployment with `nginx:1.18.0` image with `2` replicas, in the default namespace, expose port `80` on the containers.

    <details><summary>Solution</summary>
      <p>

      ```bash
      #generate yaml file
      k create deploy nginx --image=nginx:1.18.0 --replicas=2 --dry-run=client -o yaml > deploy.yaml

      #update pod.yaml
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        creationTimestamp: null
        labels:
          app: nginx
        name: nginx
      spec:
        replicas: 2
        selector:
          matchLabels:
            app: nginx
        strategy: {}
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

1.  ### update the `nginx` deployment to use image `nginx:1.19.8`.

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

1.  ### Rollback image `nginx:1.19.8` update to `nginx:1.18.0` on the nginx deployment.

    <details><summary>Solution</summary>
      <p>

      ```bash
      #update the deployment
      k rollout undo deploy nginx
      # then edit the container image
    
      OR

      # set new image on the deployment
      k set image deploy nginx nginx=nginx:1.18.0
      ```

      </p>
    </details>

1.  ### Update replicas on `nginx` deployment to `5`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      #update the replicas
      k scale deploy nginx --replicas=5
    
      OR

      # edit the deploy & set the replicas
      k edit deploy nginx 
      ```

      </p>
    </details>

1.  ### Set horizontal autoscaling on the `nginx` deployment to have `min` of `5` pods and `max` of `10` pods.

    <details><summary>Solution</summary>
      <p>

      ```bash
      #update the replicas
      k autoscale deploy nginx --min=5 --max=10

      # check the horizontal auto scaler
      k get hpa nginx
      ```

      </p>
    </details>

