#!/bin/bash

# Question 1: Pod with namespace and labels
Q1_S1=0; kubectl get pod web-pod -n exam-ns >/dev/null 2>&1 && Q1_S1=1
Q1_S2=0; [[ "$(kubectl get pod web-pod -n exam-ns -o jsonpath='{.spec.containers[0].image}' 2>/dev/null)" == "nginx:1.18.0" ]] && Q1_S2=1
Q1_S3=0; [[ "$(kubectl get pod web-pod -n exam-ns -o jsonpath='{.metadata.labels.app}' 2>/dev/null)" == "webapp" ]] && Q1_S3=1
Q1_S4=0; [[ "$(kubectl get pod web-pod -n exam-ns -o jsonpath='{.metadata.labels.tier}' 2>/dev/null)" == "frontend" ]] && Q1_S4=1
Q1_TOTAL=$((Q1_S1 + Q1_S2 + Q1_S3 + Q1_S4))

# Question 2: Deployment creation and update
Q2_S1=0; kubectl get deployment api-deployment >/dev/null 2>&1 && Q2_S1=1
Q2_S2=0; [ "$(kubectl get deployment api-deployment -o jsonpath='{.spec.replicas}' 2>/dev/null)" = "3" ] && Q2_S2=1
Q2_S3=0; [ "$(kubectl get deployment api-deployment -o jsonpath='{.spec.template.spec.containers[0].ports[0].containerPort}' 2>/dev/null)" = "80" ] && Q2_S3=1
Q2_S4=0; [[ "$(kubectl get deployment api-deployment -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)" == "nginx:1.20.0" ]] && Q2_S4=1
Q2_TOTAL=$((Q2_S1 + Q2_S2 + Q2_S3 + Q2_S4))

# Question 3: NodePort Service
Q3_S1=0; kubectl get service web-service >/dev/null 2>&1 && Q3_S1=1
Q3_S2=0; [ "$(kubectl get service web-service -o jsonpath='{.spec.type}' 2>/dev/null)" = "NodePort" ] && Q3_S2=1
Q3_S3=0; [ "$(kubectl get service web-service -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null)" = "30080" ] && Q3_S3=1
Q3_S4=0; [ "$(kubectl get service web-service -o jsonpath='{.spec.ports[0].port}' 2>/dev/null)" = "80" ] && Q3_S4=1
Q3_TOTAL=$((Q3_S1 + Q3_S2 + Q3_S3 + Q3_S4))

# Question 4: ConfigMap and Pod with env vars
Q4_S1=0; kubectl get configmap app-config >/dev/null 2>&1 && Q4_S1=1
Q4_S2=0; [[ "$(kubectl get configmap app-config -o jsonpath='{.data.database_url}' 2>/dev/null)" == "postgresql://localhost:5432/mydb" ]] && Q4_S2=1
Q4_S3=0; [[ "$(kubectl get configmap app-config -o jsonpath='{.data.api_key}' 2>/dev/null)" == "abc123xyz" ]] && Q4_S3=1
Q4_S4=0; kubectl get pod config-pod >/dev/null 2>&1 && Q4_S4=1
Q4_S5=0; kubectl get pod config-pod -o jsonpath='{.spec.containers[0].env[*].valueFrom.configMapKeyRef.name}' 2>/dev/null | grep -q "app-config" && Q4_S5=1
Q4_TOTAL=$((Q4_S1 + Q4_S2 + Q4_S3 + Q4_S4 + Q4_S5))

# Question 5: Secret and Pod with env vars
Q5_S1=0; kubectl get secret db-credentials -n secure-ns >/dev/null 2>&1 && Q5_S1=1
Q5_S2=0; [[ "$(kubectl get secret db-credentials -n secure-ns -o jsonpath='{.data.username}' 2>/dev/null | base64 -d)" == "admin" ]] && Q5_S2=1
Q5_S3=0; kubectl get pod db-pod -n secure-ns >/dev/null 2>&1 && Q5_S3=1
Q5_S4=0; kubectl get pod db-pod -n secure-ns -o jsonpath='{.spec.containers[0].env[*].valueFrom.secretKeyRef.name}' 2>/dev/null | grep -q "db-credentials" && Q5_S4=1
Q5_TOTAL=$((Q5_S1 + Q5_S2 + Q5_S3 + Q5_S4))

# Question 6: Job creation
Q6_S1=0; kubectl get job data-processor >/dev/null 2>&1 && Q6_S1=1
Q6_S2=0; [[ "$(kubectl get job data-processor -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)" == "busybox" ]] && Q6_S2=1
Q6_S3=0; [ "$(kubectl get job data-processor -o jsonpath='{.status.succeeded}' 2>/dev/null)" = "1" ] && Q6_S3=1
Q6_TOTAL=$((Q6_S1 + Q6_S2 + Q6_S3))

# Question 7: Readiness and Liveness Probes
Q7_S1=0; kubectl get pod health-check-pod >/dev/null 2>&1 && Q7_S1=1
Q7_S2=0; kubectl get pod health-check-pod -o jsonpath='{.spec.containers[0].readinessProbe.exec.command[*]}' 2>/dev/null | grep -q "ls" && Q7_S2=1
Q7_S3=0; [ "$(kubectl get pod health-check-pod -o jsonpath='{.spec.containers[0].readinessProbe.initialDelaySeconds}' 2>/dev/null)" = "5" ] && Q7_S3=1
Q7_S4=0; [ "$(kubectl get pod health-check-pod -o jsonpath='{.spec.containers[0].livenessProbe.httpGet.port}' 2>/dev/null)" = "80" ] && Q7_S4=1
Q7_S5=0; [ "$(kubectl get pod health-check-pod -o jsonpath='{.spec.containers[0].livenessProbe.initialDelaySeconds}' 2>/dev/null)" = "5" ] && Q7_S5=1
Q7_TOTAL=$((Q7_S1 + Q7_S2 + Q7_S3 + Q7_S4 + Q7_S5))

# Question 8: Multi-container Pod
Q8_S1=0; kubectl get pod multi-container-pod >/dev/null 2>&1 && Q8_S1=1
Q8_S2=0; [[ "$(kubectl get pod multi-container-pod -o jsonpath='{.spec.containers[0].image}' 2>/dev/null)" == "nginx:1.18.0" ]] && Q8_S2=1
Q8_S3=0; [[ "$(kubectl get pod multi-container-pod -o jsonpath='{.spec.containers[1].image}' 2>/dev/null)" == "redis:6-alpine" ]] && Q8_S3=1
Q8_S4=0; [ "$(kubectl get pod multi-container-pod -o jsonpath='{.spec.containers[0].ports[0].containerPort}' 2>/dev/null)" = "80" ] && Q8_S4=1
Q8_S5=0; [ "$(kubectl get pod multi-container-pod -o jsonpath='{.spec.containers[1].ports[0].containerPort}' 2>/dev/null)" = "6379" ] && Q8_S5=1
Q8_TOTAL=$((Q8_S1 + Q8_S2 + Q8_S3 + Q8_S4 + Q8_S5))

# Question 9: PersistentVolume, PVC, and Pod
Q9_S1=0; kubectl get pv pv-exam >/dev/null 2>&1 && Q9_S1=1
Q9_S2=0; [ "$(kubectl get pv pv-exam -o jsonpath='{.spec.capacity.storage}' 2>/dev/null)" = "2Gi" ] && Q9_S2=1
Q9_S3=0; kubectl get pvc pvc-exam -n storage-ns >/dev/null 2>&1 && Q9_S3=1
Q9_S4=0; [ "$(kubectl get pvc pvc-exam -n storage-ns -o jsonpath='{.spec.resources.requests.storage}' 2>/dev/null)" = "1Gi" ] && Q9_S4=1
Q9_S5=0; kubectl get pod storage-pod -n storage-ns >/dev/null 2>&1 && Q9_S5=1
Q9_S6=0; kubectl get pod storage-pod -n storage-ns -o jsonpath='{.spec.volumes[*].persistentVolumeClaim.claimName}' 2>/dev/null | grep -q "pvc-exam" && Q9_S6=1
Q9_TOTAL=$((Q9_S1 + Q9_S2 + Q9_S3 + Q9_S4 + Q9_S5 + Q9_S6))

# Question 10: Troubleshoot failing pod
Q10_S1=0; kubectl get pod broken-pod >/dev/null 2>&1 && Q10_S1=1
Q10_S2=0; [ "$(kubectl get pod broken-pod -o jsonpath='{.status.phase}' 2>/dev/null)" = "Running" ] && Q10_S2=1
Q10_TOTAL=$((Q10_S1 + Q10_S2))

# Calculate overall totals
TOTAL_SCORE=$((Q1_TOTAL + Q2_TOTAL + Q3_TOTAL + Q4_TOTAL + Q5_TOTAL + Q6_TOTAL + Q7_TOTAL + Q8_TOTAL + Q9_TOTAL + Q10_TOTAL))
MAX_SCORE=40
PERCENTAGE=$(((TOTAL_SCORE * 100) / MAX_SCORE))

# Create score.txt file with comprehensive scoring table
cat > score.txt << EOF
🎯 CKAD Mock Exam 1 - Final Score: $TOTAL_SCORE/$MAX_SCORE ($PERCENTAGE%)

Question     | Check Description                          | Score
-------------|--------------------------------------------|----- 
Question 1   | Pod with Namespace and Labels             |      
             |   Pod web-pod exists in exam-ns            | $Q1_S1    
             |   Pod uses correct image (nginx:1.18.0)    | $Q1_S2
             |   Pod has label app=webapp                 | $Q1_S3    
             |   Pod has label tier=frontend              | $Q1_S4    
             |   Subtotal                                 | $Q1_TOTAL/4  

Question 2   | Deployment Creation and Update            |      
             |   Deployment api-deployment exists         | $Q2_S1    
             |   Deployment has 3 replicas                | $Q2_S2    
             |   Container port 80 configured             | $Q2_S3    
             |   Deployment updated to nginx:1.20.0       | $Q2_S4    
             |   Subtotal                                 | $Q2_TOTAL/4  

Question 3   | NodePort Service                          |      
             |   Service web-service exists               | $Q3_S1    
             |   Service type is NodePort                 | $Q3_S2    
             |   Service uses node port 30080             | $Q3_S3    
             |   Service targets port 80                  | $Q3_S4    
             |   Subtotal                                 | $Q3_TOTAL/4  

Question 4   | ConfigMap and Environment Variables        |      
             |   ConfigMap app-config exists              | $Q4_S1    
             |   ConfigMap has database_url key           | $Q4_S2    
             |   ConfigMap has api_key key                | $Q4_S3    
             |   Pod config-pod exists                    | $Q4_S4    
             |   Pod uses ConfigMap for env vars          | $Q4_S5    
             |   Subtotal                                 | $Q4_TOTAL/5  

Question 5   | Secret and Environment Variables           |      
             |   Secret db-credentials exists in secure-ns | $Q5_S1    
             |   Secret has correct username              | $Q5_S2    
             |   Pod db-pod exists in secure-ns           | $Q5_S3    
             |   Pod uses Secret for env vars             | $Q5_S4    
             |   Subtotal                                 | $Q5_TOTAL/4  

Question 6   | Job Creation                               |      
             |   Job data-processor exists                | $Q6_S1    
             |   Job uses busybox image                   | $Q6_S2    
             |   Job completed successfully               | $Q6_S3    
             |   Subtotal                                 | $Q6_TOTAL/3  

Question 7   | Readiness and Liveness Probes              |      
             |   Pod health-check-pod exists              | $Q7_S1    
             |   Readiness probe executes ls command     | $Q7_S2    
             |   Readiness probe initial delay is 5s      | $Q7_S3    
             |   Liveness probe checks HTTP on port 80    | $Q7_S4    
             |   Liveness probe initial delay is 5s       | $Q7_S5    
             |   Subtotal                                 | $Q7_TOTAL/5  

Question 8   | Multi-container Pod                        |      
             |   Pod multi-container-pod exists           | $Q8_S1    
             |   First container uses nginx:1.18.0        | $Q8_S2    
             |   Second container uses redis:6-alpine     | $Q8_S3    
             |   nginx container exposes port 80         | $Q8_S4    
             |   redis container exposes port 6379        | $Q8_S5    
             |   Subtotal                                 | $Q8_TOTAL/5  

Question 9   | PersistentVolume, PVC, and Pod             |      
             |   PersistentVolume pv-exam exists          | $Q9_S1    
             |   PV has 2Gi storage capacity              | $Q9_S2    
             |   PVC pvc-exam exists in storage-ns       | $Q9_S3    
             |   PVC requests 1Gi storage                 | $Q9_S4    
             |   Pod storage-pod exists in storage-ns    | $Q9_S5    
             |   Pod uses PVC for volume                  | $Q9_S6    
             |   Subtotal                                 | $Q9_TOTAL/6  

Question 10  | Troubleshoot Failing Pod                   |      
             |   Pod broken-pod exists                    | $Q10_S1   
             |   Pod is in Running state                  | $Q10_S2   
             |   Subtotal                                 | $Q10_TOTAL/2 

-------------|--------------------------------------------|----- 
             | FINAL SCORE                                | $TOTAL_SCORE/$MAX_SCORE

🎯 Score: $TOTAL_SCORE/$MAX_SCORE ($PERCENTAGE%)
EOF

# Add performance feedback to score.txt
if [ "$PERCENTAGE" -ge 80 ]; then
    echo "🎉 Excellent! You passed the CKAD Mock Exam 1!" >> score.txt
elif [ "$PERCENTAGE" -ge 66 ]; then
    echo "✅ Good job! You passed the CKAD Mock Exam 1!" >> score.txt
else
    echo "❌ You need more practice. Review the failed questions." >> score.txt
fi

# Create completion signal file
touch /tmp/scoring_complete.txt

echo "Scoring completed. Results saved to score.txt"

