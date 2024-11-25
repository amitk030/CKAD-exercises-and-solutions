# Helm

[Helm](https://helm.sh/docs/)
</br>
[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).

1. ### Install Helm on your local machine.

    <details><summary>Solution</summary>
      <p>

      ```bash
      curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
      chmod 700 get_helm.sh
      ./get_helm.sh
      ```
      </p>
    </details>

1. ### Add a repo bitnami to Helm.

    <details><summary>Solution</summary>
      <p>

      ```bash
      helm repo add bitnami https://charts.bitnami.com/bitnami
      ```
      </p>
    </details>

1. ### Search for the chart `wordpress` in the bitnami repo.
  
      <details><summary>Solution</summary>
        <p>
  
        ```bash
        helm search repo bitnami/wordpress
        ```
        </p>
      </details>

1. ### Install the `wordpress` chart from the bitnami repo in the `default` namespace.

    <details><summary>Solution</summary>
      <p>

      ```bash
      helm install my-wordpress bitnami/wordpress
      ```
      </p>
    </details>

1. ### List the installed charts in the `default` namespace.

    <details><summary>Solution</summary>
      <p>

      ```bash
      helm list
      ```
      </p>
    </details>

1. ### Check the status of the `wordpress` chart.

    <details><summary>Solution</summary>
      <p>

      ```bash
      helm status my-wordpress
      ```
      </p>
    </details>

1. ### Upgrade the `wordpress` chart with the new version `9.0.0`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      helm upgrade my-wordpress bitnami/wordpress --version 9.0.0
      ```
      </p>
    </details>


1. ### Uninstall the `wordpress` chart.

    <details><summary>Solution</summary>
      <p>

      ```bash
      helm uninstall my-wordpress
      ```
      </p>
    </details>