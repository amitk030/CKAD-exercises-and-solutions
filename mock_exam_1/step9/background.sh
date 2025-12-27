#!/bin/bash

kubectl get namespace storage-ns >/dev/null 2>&1 || kubectl create namespace storage-ns

