# Challenge 1

Deploy the given architecture diagram for implementing a `Jekyll SSG`. Find the lab [here](https://kodekloud.com/topic/kubernetes-challenge-1/).

For this challenge, all resources needs to be created in `development` namespace. When writing YAML manifests, you must include `namespace: development` in the `metadata` section or switch to `development` namespace altogether by running.
```bash
k config set-context --current --namespace=development
```

## Solution

All are solved by creating a YAML manifest for each resource as directed by the details as you select each icon. Expand solutions below by clicking on the arrowhead icons.


1. `jekyll-pv` - The PV is already created, check its properties. Getting the PVC correct depends on this.
1.  <details>
    <summary>jekyll-pvc</summary>

    Apply the [manifest](./jekyll-pvc.yaml)

    </details>

1.  <details>
    <summary>jekyll</summary>

    Apply the [manifest](./jekyll-pod.yaml)

    The pod will take at least 30 seconds to initialize.

    </details>

1.  <details>
    <summary>jekyll-node-service</summary>

    Apply the [manifest](./jekyll-node-service.yaml)

    </details>

1.  <details>
    <summary>developer-role</summary>
    </br>

    ```
    kubectl create role developer-role --resource=pods,svc,pvc --verb="*" -n development
    ```

    </br>--- OR ---</br></br>Apply the [manifest](./developer-role.yaml)

    </details>

1.  <details>
    <summary>developer-rolebinding</summary>
    </br>

    ```
    kubectl create rolebinding developer-rolebinding --role=developer-role --user=martin -n development
    ```

    </br>--- OR ---</br></br>Apply the [manifest](./developer-rolebinding.yaml)

    </details>

1.  <details>
    <summary>kube-config</summary>

    ```bash
    kubectl config set-credentials martin --client-certificate ./martin.crt --client-key ./martin.key
    kubectl config set-context developer --cluster kubernetes --user martin
    ```

    </details>

1.  <details>
    <summary>martin</summary>

    ```bash
    kubectl config use-context developer
    ```

    </details>

