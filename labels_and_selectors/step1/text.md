### name a pod `sumo` with image `nginx` and label it `tier=frontend`
    
  <details><summary>Solution</summary>

    k run sumo --image=nginx --labels=tier=frontend

    ---

    # update metadata of pod yaml
    apiVersion: v1
    kind: Pod
    metadata:
      creationTimestamp: null
      labels: # add label
        tier: frontend
      name: sumo
    spec:
      containers:
      - image: nginx
        name: sumo
        resources: {}
      dnsPolicy: ClusterFirst
      restartPolicy: Always
    status: {}

  </details>
