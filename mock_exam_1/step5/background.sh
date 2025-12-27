#!/bin/bash

kubectl get namespace secure-ns >/dev/null 2>&1 || kubectl create namespace secure-ns

