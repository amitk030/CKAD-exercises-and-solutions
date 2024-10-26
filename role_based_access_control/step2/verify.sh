kubectl config view -o json | jq '.users[] | select(.name=="ardino")' &> /dev/null

if [ $? -eq 0 ]; then
    echo "User 'ardino' created successfully"
else
    echo "User 'ardino' not found in kubeconfig"
    exit 1
fi