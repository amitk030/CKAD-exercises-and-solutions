#!/bin/bash

job_exists=$(kubectl get job parallel-job --ignore-not-found)

if [ -z "$job_exists" ]; then
  echo "Job 'parallel-job' does not exist."
  exit 1
fi

parallelism=$(kubectl get job parallel-job -o jsonpath='{.spec.parallelism}')
completions=$(kubectl get job parallel-job -o jsonpath='{.spec.completions}')

if [ "$parallelism" -eq 3 ] && [ "$completions" -eq 3 ]; then
  echo "Job 'parallel-job' has the correct parallelism and completions."
else
  echo "Job 'parallel-job' does not have the correct parallelism and completions."
  echo "Parallelism: $parallelism, Completions: $completions"
  exit 1
fi

command=$(kubectl get job parallel-job -o jsonpath='{.spec.template.spec.containers[0].command}')
image=$(kubectl get job parallel-job -o jsonpath='{.spec.template.spec.containers[0].image}')

if [ "$image" == "busybox" ]; then
  echo "Job 'parallel-job' has the container image."
else
  echo "Job 'parallel-job' does not have the correct command and container image."
  echo "Command: $command, Image: $image"
  exit 1
fi

echo "All verifications passed for job 'parallel-job'."