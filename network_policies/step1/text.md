### A deployment `nginx` already exists with 2 pods and a service `ngx-svc` exposed on port `80`. create a network policy named `net-ingress` such that only pods with lable `app=serve` will be about to make request to these nginx pods on port `80`.

<details><summary>Solution</summary>
  <p>

```bash
# Define the NetworkPolicy YAML
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: net-ingress
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

# Apply the NetworkPolicy
kubectl create -f network-policy.yaml
```

  </p>
</details>