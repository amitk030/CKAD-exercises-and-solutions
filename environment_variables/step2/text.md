### write env variables of `mypod` to `mypod-env.txt` and check `env1=value1` and `env2=value2` environment variables are present.
    
<details><summary>Solution</summary>
  <p>

  ```bash
  # write env to a file
  k exec mypod -ti -- env > mypod-env.txt

  # print env variables
  cat mypod-env.txt
  # env1 and env2 must be present
  ```

  </p>
</details>
