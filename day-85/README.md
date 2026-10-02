# Day 85 — EKS Cluster Operations & Verification

## Goal

Verify active EKS cluster health, inspect Kubernetes node and pod scheduling, review CloudWatch metrics, and confirm application exposure via AWS LoadBalancer.

## Key Operational Verifications

1. **EKS Cluster Version & Nodes:** Confirmed node running Kubernetes `v1.31` in `ap-south-2` with `Ready` status.
2. **Pod Scheduling & Health:** Verified application container is actively `Running` with internal IP assignment.
3. **Container Insights & Observability:** Validated CloudWatch log groups and metric alarms tracking cluster performance.
4. **Kubernetes Cluster Events:** Checked cluster events confirming clean image pull from ECR and successful pod creation.
5. **LoadBalancer Endpoint:** Verified active application deployment rollouts and external LoadBalancer DNS resolution.

---

## 📸 Proof of Execution & Diagnostics

### 1. EKS Node Health & Active Pod Status
![EKS Nodes and Pods](images/01-cluster-status-and-upgrade-error.png)

### 2. CloudWatch Metrics & Cluster Observability
![CloudWatch Metrics](images/02-eks-insights-list.png)

### 3. CloudWatch Log Groups & Diagnostics
![CloudWatch Log Groups](images/03-eks-insight-details.png)

### 4. Kubernetes Events & Container Lifecycles
![Kubernetes Events Audit](images/04-terraform-variables-check.png)

### 5. Application Rollout & LoadBalancer Service Verification
![Rollout Status and Service Output](images/05-clean-rebuild-plan.png)
