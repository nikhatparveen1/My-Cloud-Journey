# Day 43 — Docker Security Scanning with Trivy

## Goal

Add container security scanning to the GitHub Actions CI pipeline.

## Pipeline

Developer
    ↓
git push
    ↓
GitHub Actions
    ↓
Checkout
    ↓
Install dependencies
    ↓
Run tests
    ↓
Build Docker image
    ↓
Trivy vulnerability scan
    ↓
PASS / FAIL

## Trivy

Trivy is a security scanner used to identify vulnerabilities
in container images and other targets.

## Important Concepts

Vulnerability
→ A known security weakness.

Severity
→ Indicates the seriousness of a vulnerability.

HIGH
→ Serious vulnerability.

CRITICAL
→ Very serious vulnerability.

Security gate
→ A CI step that can stop the pipeline when a security
condition is not satisfied.

exit-code: 1
→ Makes the Trivy step fail when the configured scan
finds matching vulnerabilities.

ignore-unfixed: true
→ Ignores vulnerabilities for which no fix is currently
available.

## Important Workflow Step

uses: aquasecurity/trivy-action@v0.36.0

with:

image-ref: "my-cloud-journey:${{ github.sha }}"
severity: "HIGH,CRITICAL"
ignore-unfixed: true
exit-code: "1"

## Main Lesson

Day 42:
Test whether the application works.

Day 43:
Check whether the container image has serious known
security vulnerabilities.

## Cost Safety

No AWS resources are required for Day 43.

The temporary Day 39 EC2 was already destroyed.

## Company-Level Pipeline

Test
  ↓
Build
  ↓
Security Scan
  ↓
Only then continue toward deployment

