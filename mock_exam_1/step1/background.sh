#!/bin/bash

kubectl get namespace exam-ns >/dev/null 2>&1 || kubectl create namespace exam-ns

