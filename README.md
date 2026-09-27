# My Cloud Journey

100-Day Cloud & DevOps Learning Journey

## Phases

- [ ] Phase 0 — Tooling
- [ ] Phase 1 — Linux & Networking Foundations
- [ ] Phase 2 — AWS Cloud & Terraform
- [ ] Phase 3 — Docker & CI/CD
- [ ] Phase 4 — Serverless & AI
- [ ] Phase 5 — Kubernetes & EKS
- [ ] Phase 6 — Portfolio & Interview Preparation

## Environment

- OS: CachyOS
- AWS Region: ap-south-2
- AWS CLI: Installed
- Terraform: Installed
- Git: Installed
- Docker: In progress


# Phase 2 — Custom AWS VPC with Terraform

## Overview

In Phase 2, I built a custom AWS VPC using Terraform.

The VPC uses a public subnet and a private subnet to separate
internet-facing infrastructure from private resources.

## Architecture

```text
                         Internet
                            |
                            v
                    Internet Gateway
                            |
              +-------------+-------------+
              |                           |
              v                           v
        Public Subnet               Private Subnet
        10.0.1.0/24                 10.0.2.0/24
              |                           |
              v                           v
        Bastion EC2                  Private EC2
              |                           |
              |                           v
              |                     NAT Instance
              |                           |
              +---------------------------+
                                          |
                                          v
                                       Internet


## Phase 3 — Docker, Security Scanning & CI/CD Pipeline

### Overview
In Phase 3, I automated application testing, container building, vulnerability scanning, and live deployment verification onto AWS EC2 using GitHub Actions and GitHub Container Registry (GHCR).

### Extended Architecture & CI/CD Flow
```text
[ Developer Workstation (CachyOS) ]
               │
               │ (git push)
               ▼
     [ GitHub Repository ]
               │
               │ (GitHub Actions Trigger)
               ▼
┌─────────────────────────────────────────────────────────┐
│               Automated CI/CD Pipeline                  │
├─────────────────────────────────────────────────────────┤
│ 1. Pytest Unit Verification (/ & /health routes)        │
│ 2. Docker Image Build                                   │
│ 3. Vulnerability Scanning (Trivy Security)              │
│ 4. Publish Artifact to GHCR (:full-git-sha)             │
└─────────────────────────────────────────────────────────┘
               │
               │ (Terraform IaC Provisioning)
               ▼
┌─────────────────────────────────────────────────────────┐
│               AWS Cloud Infrastructure                  │
│            Region: ap-south-2 (Hyderabad)               │
├─────────────────────────────────────────────────────────┤
│ • Ephemeral EC2 Instance (t3.micro)                     │
│ • Custom Security Group (Inbound SSH + Port 5000)       │
│ • Docker Runtime Container Execution                    │
└─────────────────────────────────────────────────────────┘
               │
               │ (Live Verification: curl / & /health)
               ▼
┌─────────────────────────────────────────────────────────┐
│              Zero-Cost Safety Cleanup                   │
├─────────────────────────────────────────────────────────┤
│ • Automated `terraform destroy` (Restores cost to $0)   │
└─────────────────────────────────────────────────────────┘

Key Milestone Achievements (Days 42–50)
Automated CI/CD: Built GitHub Actions workflow verifying Python tests, building Docker containers, and scanning image layers with Trivy.

Immutable Artifacts: Published images tagged with 40-character Git SHAs (ghcr.io/nikhatparveen1/my-cloud-journey:<SHA>) to eliminate configuration drift.

Microservice Reliability: Added diagnostic health check endpoints (/health) returning HTTP 200 OK JSON responses.

Zero-Cost Policy: Maintained a strict $0 ongoing compute budget by using temporary, ephemeral EC2 instances torn down via terraform destroy.

💻 Tech Stack Summary
OS: CachyOS (Arch Linux)

Cloud Platform: AWS (ap-south-2 - Hyderabad)

Infrastructure as Code: Terraform

CI/CD & Registry: GitHub Actions, GHCR

Security & Testing: Trivy, Pytest

Containerization & App: Docker, Python (Flask)
EOF

