### A pod named `health-check-pod` with image `nginx` exists in the `default` namespace. Add a readiness probe that executes the command `ls /usr/share/nginx/html` and a liveness probe that checks HTTP on port `80` at path `/`. The initial delay should be `5` seconds for both probes.

