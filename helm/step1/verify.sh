#!/bin/bash

# Check if Helm is installed
if command -v helm &> /dev/null
then
    echo "Helm is installed"
    helm version
else
    echo "Helm is not installed"
    exit 1
fi