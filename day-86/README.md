# Day 86 — EKS Load Testing

## Goal

Performed a controlled load test against the EKS-hosted
application and observed the application's behavior through
Kubernetes and AWS monitoring.

## Test

A small controlled request burst was used rather than
high-volume traffic.

## Observed

- Application remained available
- Pod health was monitored
- Kubernetes events were reviewed
- Monitoring data was inspected
- Application behavior under load was documented

## Safety

Load testing was intentionally kept small to avoid
unnecessary AWS resource consumption.

---

## Proof & Verification Artifacts

### 1. Controlled Load Test Execution
![Load Test Execution](screenshots/01-load-test-results.png)

### 2. Post-Load Pod & Deployment Health
![Post-Load Pod Health](screenshots/02-pod-health-post-load.png)

### 3. CloudWatch Monitoring & Log Verification
![CloudWatch Monitoring](screenshots/03-cloudwatch-monitoring.png)
