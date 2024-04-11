![](https://gaforgithub.azurewebsites.net/api?repo=CKAD-exercises/core_concepts&empty)
# Core Concepts [pods, namespaces, Replica Sets, Deployments]


1. ### create `cygnus` namespace.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k create ns cygnus 
      ```

      </p>
    </details>

1. ### Create a namespace called `cygnus` and create a pod with name `alpha` and image `nginx` in this namespace.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k run alpha --image=nginx --restart=Never -n cygnus
      ```

      </p>
    </details>

1.  ### create a pod with name `theta` and image `nginx` in `default` namespace and write `env` variables of that pod to file `theta-env.txt`.

    <details><summary>Solution</summary>
      <p>

      ```bash
      k run theta --image=nginx
      k exec theta -ti -- env > theta-env.txt
      ```
      -- OR --

      ```bash
      k run theta --image=nginx -ti -- env # this will print env variables copy and paste it to theta-env.txt
      ```

      </p>
    </details>
