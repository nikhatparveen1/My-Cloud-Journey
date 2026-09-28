# ☁️ My Cloud Journey

### 100-Day Cloud & DevOps Engineering Journey

A hands-on journey from Linux and networking fundamentals to **AWS, Terraform, Docker, CI/CD, Serverless AI, Kubernetes/EKS, and Observability**.

This repository documents the infrastructure I build, the problems I solve, the mistakes I encounter, and the concepts I learn along the way.

> **Build → Break → Troubleshoot → Understand → Automate → Document**

---

## 🚀 Journey Progress

| Phase      |   Days | Focus                                       | Status |
| ---------- | -----: | ------------------------------------------- | :----: |
| 🧰 Phase 0 |    1–2 | Tooling & Git                               |    ✅   |
| 🐧 Phase 1 |   3–11 | Linux & Networking Foundations              |    ✅   |
| ☁️ Phase 2 |  12–35 | AWS, VPC & Terraform                        |    ✅   |
| 🐳 Phase 3 |  36–50 | Docker, Security & CI/CD                    |    ✅   |
| 🤖 Phase 4 |  51–75 | Serverless & AI                             |   🔜   |
| ☸️ Phase 5 |  76–90 | Kubernetes, EKS & Observability             |   🔜   |
| 💼 Phase 6 | 91–100 | Portfolio, Revision & Interview Preparation |   🔜   |

**Current milestone: Day 50 / 100**

---

# 🧭 What I'm Building

This journey is not just a collection of tutorials.

The goal is to gradually build the skills required to design, provision, deploy, secure, monitor, and explain cloud infrastructure.

```text
Linux
  ↓
Networking
  ↓
AWS Fundamentals
  ↓
Terraform
  ↓
Docker
  ↓
CI/CD
  ↓
Serverless + AI
  ↓
Kubernetes / EKS
  ↓
Observability
  ↓
Portfolio + Interview Readiness
```

---

# 🏗️ Major Projects

## Project 1 — AWS Infrastructure as Code

**Focus:** AWS VPC + Terraform

Built a custom AWS networking environment using Terraform with:

* Custom VPC
* Public subnet
* Private subnet
* Internet Gateway
* Route tables
* Bastion host architecture
* NAT-based private subnet internet access
* Terraform-based infrastructure management

### Architecture

```text
                         🌐 Internet
                              │
                              ▼
                    ┌──────────────────┐
                    │ Internet Gateway │
                    └────────┬─────────┘
                             │
              ┌──────────────┴──────────────┐
              │       Custom VPC             │
              │        10.0.0.0/16           │
              │                              │
              │  ┌────────────────────────┐  │
              │  │     Public Subnet      │  │
              │  │      10.0.1.0/24       │  │
              │  │                        │  │
              │  │   Bastion EC2          │  │
              │  │   NAT Instance         │  │
              │  └───────────┬────────────┘  │
              │              │               │
              │       Private Route Table    │
              │              │               │
              │  ┌───────────▼────────────┐  │
              │  │     Private Subnet     │  │
              │  │      10.0.2.0/24       │  │
              │  │                        │  │
              │  │   Private EC2          │  │
              │  │   No Public IP         │  │
              │  └────────────────────────┘  │
              └──────────────────────────────┘
```

### Key Concepts

* VPC architecture
* CIDR
* Public vs private subnets
* Route tables
* Internet Gateway
* NAT
* Bastion access
* Private EC2 networking
* Infrastructure as Code
* Terraform state

---

# 🐳 Project 2 — Containerized Application + CI/CD

**Focus:** Docker + GitHub Actions + Security

The second major project extends the infrastructure knowledge into application delivery.

The pipeline performs:

```text
Developer
    │
    │ git push
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
    │
    ├── Pytest
    ├── Docker Build
    ├── Trivy Security Scan
    └── Publish Image
             │
             ▼
        GitHub Container
           Registry
             │
             ▼
          AWS EC2
             │
             ▼
       Running Container
             │
             ▼
        Health Check
```

### Key capabilities

* Docker containerization
* Python/Flask application
* Automated tests with Pytest
* GitHub Actions CI/CD
* Docker image builds
* Trivy vulnerability scanning
* GitHub Container Registry
* Immutable Git-SHA image tagging
* Application health checks
* Automated deployment verification
* Temporary infrastructure cleanup

### Reliability

The application exposes health verification through:

```text
/
 /health
```

The `/health` endpoint provides a simple way for the deployment workflow to verify that the application is responding successfully.

---

# 🔐 Security & Cost-Safety Principles

Security and cost awareness are part of the learning process.

### AWS Safety Workflow

```text
STOP
  ↓
VERIFY
  ↓
PROCEED
```

Before AWS changes, I verify:

* Region
* Resource
* Network exposure
* Security Group rules
* Credentials/secrets
* Expected cost
* Cleanup requirements

### Cleanup Philosophy

Temporary AWS infrastructure is destroyed after learning sessions when it is no longer required.

```text
Create
  ↓
Learn
  ↓
Test
  ↓
Verify
  ↓
Destroy
```

The goal is to avoid leaving unnecessary compute resources running.

---

# 🧪 Engineering Practices

Throughout the journey, I am gradually moving from simply making things work toward making them **repeatable, testable, secure, and documented**.

Current practices include:

* Infrastructure as Code
* Git version control
* Automated testing
* CI/CD
* Containerization
* Vulnerability scanning
* Health checks
* Immutable image tagging
* Architecture documentation
* AWS cost-safety checks
* Reproducible infrastructure

---

# 🤖 Phase 4 — Serverless & AI

### Days 51–75

The next phase focuses on AWS serverless architecture and AI integration.

Planned architecture:

```text
                 Object Upload
                      │
                      ▼
                     S3
                      │
                 S3 Event
                      │
                      ▼
                   Lambda
                      │
          ┌───────────┴───────────┐
          ▼                       ▼
     Rekognition              DynamoDB
          │                       │
          └───────────┬───────────┘
                      ▼
                 API Gateway
```

### Topics

* AWS Lambda
* boto3
* S3 events
* IAM
* Amazon Rekognition
* DynamoDB
* API Gateway
* Error handling
* Dead-letter queues

This phase will become the foundation for **Project 3 — Serverless AI**.

---

# ☸️ Phase 5 — Kubernetes & EKS

### Days 76–90

The next major stage moves into container orchestration.

### Core topics

* Kubernetes architecture
* YAML
* Pods
* Deployments
* Services
* Ingress
* ConfigMaps
* Secrets
* Volumes
* Helm
* kubectl
* Amazon EKS

### Observability

The monitoring stack will progress in this order:

```text
Application
    ↓
Metrics
    ↓
Prometheus
    ↓
Grafana
    ↓
Alerts
    ↓
Alertmanager
```

This becomes the foundation for **Project 4 — EKS + Observability**.

---

# 💼 Phase 6 — Portfolio & Interview Preparation

### Days 91–100

The final phase is not simply about learning more tools.

It is about turning everything learned into **understanding that can be demonstrated and explained**.

### Revision areas

```text
Linux
Networking
AWS
Terraform
Docker
CI/CD
Serverless
Kubernetes
Observability
```

### Final preparation

* Project architecture explanations
* Troubleshooting scenarios
* Cloud/DevOps interview questions
* Project walkthroughs
* Resume preparation
* GitHub portfolio cleanup
* Internship/job preparation

---

# 📊 Technology Stack

### Cloud

* AWS
* EC2
* VPC
* S3
* Lambda
* DynamoDB
* API Gateway
* Rekognition
* EKS

### Infrastructure

* Terraform
* Terraform Modules
* Terraform State
* AWS Networking

### Containers

* Docker
* GitHub Container Registry

### CI/CD

* GitHub Actions
* Automated Testing
* Security Scanning
* Deployment Verification

### Security

* IAM
* Security Groups
* Trivy
* SSH security
* Private networking

### Kubernetes

* Kubernetes
* EKS
* kubectl
* Helm

### Observability

* Prometheus
* Grafana
* Alertmanager

### Development

* Python
* Flask
* Git
* GitHub

---

# 💻 Environment

| Tool       | Environment             |
| ---------- | ----------------------- |
| OS         | CachyOS                 |
| AWS Region | `ap-south-2`            |
| Git        | Installed               |
| AWS CLI    | Installed               |
| Terraform  | Installed               |
| Docker     | Used throughout Phase 3 |
| GitHub     | Project repository      |

---

# 📁 Repository Structure

The repository follows the journey chronologically.

```text
My-Cloud-Journey/
│
├── day-01/
├── day-02/
├── day-03/
├── ...
│
├── day-19/
│   └── terraform-subnets/
│
├── ...
│
├── day-42/
├── ...
├── day-50/
│
├── project-1/
├── project-2/
├── project-3/
└── project-4/
```

Each stage contains the code, notes, configuration, troubleshooting, and evidence associated with that part of the journey.

---

# 🧠 Learning Philosophy

This journey follows a practical learning cycle:

```text
        LEARN
          │
          ▼
        BUILD
          │
          ▼
       BREAK IT
          │
          ▼
     TROUBLESHOOT
          │
          ▼
       UNDERSTAND
          │
          ▼
       AUTOMATE
          │
          ▼
      DOCUMENT
          │
          └──────────► REPEAT
```

The goal is not to memorize commands.

The goal is to eventually understand **why the architecture works, how the components communicate, how to troubleshoot failures, and how to automate the same work reliably.**

---

# 📈 Journey Status

```text
Days 01–11   ████████████████████  Foundations
Days 12–35   ████████████████████  AWS + Terraform
Days 36–50   ████████████████████  Docker + CI/CD
Days 51–75   ░░░░░░░░░░░░░░░░░░░░  Serverless + AI
Days 76–90   ░░░░░░░░░░░░░░░░░░░░  Kubernetes + EKS
Days 91–100  ░░░░░░░░░░░░░░░░░░░░  Portfolio + Interviews
```

**Current milestone: Day 50 / 100**

---

# 🎯 End Goal

By the end of this journey, the goal is to be able to:

```text
Design
  ↓
Provision
  ↓
Secure
  ↓
Containerize
  ↓
Test
  ↓
Automate
  ↓
Deploy
  ↓
Monitor
  ↓
Troubleshoot
  ↓
Explain
```

—not just run commands.

---

## 📌 Repository

**My Cloud Journey — 100 Days of Cloud & DevOps**

Built one day at a time.
Documented one concept at a time.
Improved one project at a time.


