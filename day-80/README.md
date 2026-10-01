# Day 80 — EKS Cluster Creation

## Goal

Created the Project 4 Amazon EKS cluster using Terraform
and verified Kubernetes connectivity.

## Architecture

CachyOS
  ↓
kubectl
  ↓
Amazon EKS
  ↓
Managed Node Group
  ↓
Kubernetes Worker Node

## Verification

The following were verified:

- EKS cluster exists
- EKS cluster status is ACTIVE
- Kubernetes API is reachable
- kubectl context is configured
- Worker node is Ready
- Managed node group is operational
- Desired node count is 1

## Screenshots & Portfolio Proof

## Screenshots & Portfolio Proof

### 1. EKS Cluster Status (ACTIVE)
![EKS Cluster Active](screenshots/eks-cluster-active.png)

### 2. EKS Node Group Configuration (`Desired = 1`)
![Node Group Status](screenshots/nodegroup-status.png)

### 3. Worker Node Status (`kubectl get nodes`)
![Kubectl Get Nodes](screenshots/kubectl-get-nodes.png)

### 4. Terraform Apply Output
![Terraform Apply Output](screenshots/terraform-apply.png)
## AWS Safety

The cluster was intentionally deployed with a single
worker node for the learning environment.

EKS costs were considered before cluster creation.
