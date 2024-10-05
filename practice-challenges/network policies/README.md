## Network Policy

[Network Policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
</br>

[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1.  ### A deployment `nginx` already exists with 2 pods and a service `ngx-svc` exposed on port `80`. create a network policy such that only pods with lable `app=serve` will be about to make request to these nginx pods on port `80`.

<details><summary>Setup</summary>
  <p>

```bash
# Define the Deployment YAML
cat <<EOF > nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF

# Define the Service YAML
cat <<EOF > ngx-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: ngx-svc
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
EOF

# Apply the Deployment and Service
kubectl create -f nginx-deployment.yaml
kubectl create -f ngx-svc.yaml
```

  </p>
</details>

<details><summary>Solution</summary>
  <p>

  ```bash
# Define the NetworkPolicy YAML
cat <<EOF > network-policy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-serve-to-nginx
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: nginx
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: serve
    ports:
    - protocol: TCP
      port: 80
EOF

# Apply the NetworkPolicy
kubectl create -f network-policy.yaml
  ```

  </p>
</details>

1.  ### A deployment `nginx-1` already exists with 2 pods and a service `ngx-svc-1` exposed on port `80`. Add label `type=deployment`  to pods of deployments `nginx` & `nginx-1`. Update the existing network policy to include all these pods.

<details><summary>Setup</summary>
  <p>

```bash
# Define the Deployment YAML
cat <<EOF > nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF

# Define the Service YAML
cat <<EOF > ngx-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: ngx-svc
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
EOF

# Apply the Deployment and Service
kubectl create -f nginx-deployment.yaml
kubectl create -f ngx-svc.yaml
```

  </p>
</details>

<details><summary>Solution</summary>
  <p>

  ```bash
# Define the NetworkPolicy YAML
cat <<EOF > network-policy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-serve-to-nginx
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: nginx
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: serve
    ports:
    - protocol: TCP
      port: 80
EOF

# Apply the NetworkPolicy
kubectl create -f network-policy.yaml
  ```

  </p>
</details>