#!/bin/bash

kubectl create deployment app-deployment --image=nginx:1.18.0 --replicas=2 --port=80 2>/dev/null
kubectl label deployment app-deployment app=webapp --overwrite 2>/dev/null

