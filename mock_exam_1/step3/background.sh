#!/bin/bash

kubectl get deployment app-deployment >/dev/null 2>&1 || kubectl create deployment app-deployment --image=nginx:1.18.0 --replicas=2 --port=80
kubectl label deployment app-deployment app=webapp --overwrite 2>/dev/null

