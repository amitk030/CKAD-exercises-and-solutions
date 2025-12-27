#!/bin/bash

kubectl get pod health-check-pod >/dev/null 2>&1 || kubectl run health-check-pod --image=nginx --restart=Never
sleep 2

