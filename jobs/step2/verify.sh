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

volume_mounts=$(kubectl get job script-job -o jsonpath='{.spec.template.spec.volumes[?(@.configMap.name=="job-script")]}')
if [ -z "$volume_mounts" ]; then
  echo "Job 'script-job' does not mount ConfigMap 'job-script' as a volume."
  exit 1
else
  echo "Job 'script-job' mounts ConfigMap 'job-script' as a volume."
fi

echo "Both ConfigMap 'job-script' and Job 'script-job' exist and the job mounts the ConfigMap as a volume."