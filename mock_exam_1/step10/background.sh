#!/bin/bash

kubectl get pod broken-pod >/dev/null 2>&1 || kubectl run broken-pod --image=invalid-image:latest --restart=Never
sleep 2

