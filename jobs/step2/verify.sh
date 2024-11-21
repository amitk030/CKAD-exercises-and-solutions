#!/bin/bash

configmap_exists=$(kubectl get configmap job-script --ignore-not-found)
if [ -z "$configmap_exists" ]; then
  echo "ConfigMap 'job-script' does not exist."
  exit 1
else
  echo "ConfigMap 'job-script' exists."
fi

job_exists=$(kubectl get job script-job --ignore-not-found)
if [ -z "$job_exists" ]; then
  echo "Job 'script-job' does not exist."
  exit 1
else
  echo "Job 'script-job' exists."
fi

echo "Both ConfigMap 'job-script' and Job 'script-job' exist."