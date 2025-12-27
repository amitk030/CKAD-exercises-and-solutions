#!/bin/bash

kubectl run broken-pod --image=invalid-image:latest --restart=Never 2>/dev/null
sleep 2

