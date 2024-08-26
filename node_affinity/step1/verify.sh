#!/bin/bash

NODE_NAME="node01"

LABEL_KEY="scheduleNodes"
LABEL_VALUE="True"

LABEL_EXISTS=$(kubectl get node $NODE_NAME -o jsonpath="{.metadata.labels.$LABEL_KEY}" 2>/dev/null)

if [ "$LABEL_EXISTS" == "$LABEL_VALUE" ]; then
    echo "PASS: Node '$NODE_NAME' is labeled with '$LABEL_KEY=$LABEL_VALUE'."
    exit 0
else
    echo "FAIL: Node '$NODE_NAME' does not have the label '$LABEL_KEY=$LABEL_VALUE'."
    exit 1
fi
