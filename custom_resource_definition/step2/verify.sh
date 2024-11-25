#!/bin/bash

ticket=$(kubectl get busticket my-ticket -o json)

if [ -z "$ticket" ]; then
  echo "BusTicket resource 'my-ticket' not found."
  exit 1
fi

from=$(echo "$ticket" | jq -r '.spec.from')
to=$(echo "$ticket" | jq -r '.spec.to')
seats=$(echo "$ticket" | jq -r '.spec.seats')

if [ "$from" == "New Delhi" ] && [ "$to" == "Mumbai" ] && [ "$seats" -eq 5 ]; then
  echo "BusTicket resource 'my-ticket' is created with the correct details."
else
  echo "BusTicket resource 'my-ticket' details do not match."
  exit 1
fi