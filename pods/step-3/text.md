### Troubleshoot and fix the failing pod `theta` in the `default` namespace.

**Hint**: Use `kubectl describe pod theta` or `kubectl get events` to investigate the issue.

<details><summary>Solution</summary>
<p>

```bash
kubectl get pod theta

kubectl describe pod theta

# The pod is using image 'nginx:invalid-tag' which doesn't exist

# Get the current pod YAML
kubectl get pod theta -o yaml > theta-pod.yaml

# Edit the YAML file to fix the image
# Change image: nginx:invalid-tag to image: nginx

kubectl delete -f theta-pod.yaml
OR
kubectl delete pod theta

kubectl apply -f theta-pod.yaml

kubectl get pod theta
```

</p>
</details> 