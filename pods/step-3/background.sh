#!/bin/bash

# Create a pod with an invalid image tag that will fail to start
kubectl run theta --image=nginx:invalid-tag --restart=Never

echo "Created pod 'theta' with invalid image tag. The pod should fail to start."
echo "This sets up the troubleshooting scenario for the exercise." 