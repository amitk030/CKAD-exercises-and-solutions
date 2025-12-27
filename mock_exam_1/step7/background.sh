#!/bin/bash

kubectl run health-check-pod --image=nginx --restart=Never 2>/dev/null
sleep 2

