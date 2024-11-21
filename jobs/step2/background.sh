#!/bin/bash

cat << EOF > script.sh
#!/bin/bash

  echo "CPU Details:"
  lscpu

  echo "Memory Details:"
  free -h

  echo "Disk Usage:"
  df -h

  echo "Uptime:"
  uptime
EOF

chmod +x script.sh

kubectl create configmap job-script --from-file=script.sh

