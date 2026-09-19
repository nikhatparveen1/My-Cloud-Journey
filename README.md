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
