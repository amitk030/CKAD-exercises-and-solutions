#!/bin/bash

cronjob_exists=$(kubectl get cronjob eg-cron --ignore-not-found)

if [ -z "$cronjob_exists" ]; then
  echo "CronJob 'eg-cron' does not exist."
  exit 1
fi

schedule=$(kubectl get cronjob eg-cron -o jsonpath='{.spec.schedule}')

if [ "$schedule" != "* * * * *" ]; then
  echo "CronJob 'eg-cron' does not run every minute. Current schedule: $schedule"
  exit 1
fi

job_name=$(kubectl get jobs --selector=job=eg-cron --sort-by=.metadata.creationTimestamp -o jsonpath='{.items[-1].metadata.name}')
log_output=$(kubectl logs job/$job_name)

if [[ "$log_output" != *"Every minute CronJob"* ]]; then
  echo "CronJob 'eg-cron' does not log 'Every minute CronJob'."
  exit 1
fi

echo "CronJob 'eg-cron' exists, runs every minute, and logs 'Every minute CronJob'."