### There are 2 pods. A `nginx` pod exposed on port `8080` and a `busybox` pod exposed on port `80`. create a network policy `net-egress` such that the busybox pod is able to make request to `nginx` pod only on port `8080`. check the labels on the pods

<details><summary>Solution</summary>
  <p>

  ```bash
  # check labels on the pods
  k get po --show-labels


k apply -f -<<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: net-egress
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: busybox
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          run: nginx
    ports:
    - protocol: TCP
      port: 8080
EOF
  ```

  </p>
</details>