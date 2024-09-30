### There exist 3 `nginx` pods with names `pod-1`, `pod-2` & `pod-3` with label `app=frontend`. If you make a request to each pod on their ip they will return __responding from pod-x__ . Now create a service `frontend` with type `ClusterIP` exposing these pods as a service on port `80`.

### Try polling with this script to the service & see the results
```bash
# get the service ip
k get svc

# run
while true; do curl -s <service-ip>; sleep 1; done

# it will distribute request to the 3 created pods
```

<details><summary>Solution</summary>
  <p>

  ```bash
  # create service yaml file
  apiVersion: v1
  kind: Service
  metadata:
    name: frontend
  spec:
    selector:
      app: frontend
    ports:
      - protocol: TCP
        port: 80
        targetPort: 80
    type: ClusterIP

  # create service
  k create -f service.yaml
  
  ```

  </p>
</details>