### A deployment `nginx-1` already exists with 2 pods and a service `ngx-svc-1` exposed on port `80`. Add label `type=deployment`  to pods of deployments `nginx` & `nginx-1`. Update the existing network policy yaml file `net-ingress.yaml` to include all these pods.

<details><summary>Solution</summary>
  <p>

```bash
# network_policy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: net-ingress
  namespace: default
spec:
  podSelector:
    matchLabels:
      type: deployment # This will match both `nginx` and `nginx-1` pods
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


k create -f network_policy.yaml
```

  </p>
</details>