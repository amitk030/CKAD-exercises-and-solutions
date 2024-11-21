#!/bin/bash

verify_retry_job() {
  local job_name="retry-job"
  local expected_retries=4

  job_exists=$(kubectl get jobs | grep -w "$job_name")

  if [ -z "$job_exists" ]; then
    echo "Job '$job_name' does not exist."
    exit 1
  fi

  actual_retries=$(kubectl get job "$job_name" -o jsonpath='{.spec.backoffLimit}')

  if [ "$actual_retries" -eq "$expected_retries" ]; then
    echo "Job '$job_name' exists and has the correct retry count of $expected_retries."
  else
    echo "Job '$job_name' exists but has an incorrect retry count of $actual_retries. Expected: $expected_retries."
    exit 1
  fi
}

verify_retry_job