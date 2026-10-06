# ☁️ My Cloud Journey

### 100-Day Cloud & DevOps Engineering Journey

A hands-on journey from Linux and networking fundamentals to **AWS, Terraform, Docker, CI/CD, Serverless AI, Kubernetes/EKS, Observability, and a self-service Internal Developer Platform.**

This repository documents the infrastructure I build, the problems I solve, the mistakes I encounter, and the concepts I learn along the way.

> **Build → Break → Troubleshoot → Understand → Automate → Document**

---

## 🚀 Journey Progress

| Phase      |   Days | Focus                                       | Status |
| ---------- | -----: | -------------------------------------------- | :----: |
| 🧰 Phase 0 |    1–2 | Tooling & Git                                |    ✅   |
| 🐧 Phase 1 |   3–11 | Linux & Networking Foundations               |    ✅   |
| ☁️ Phase 2 |  12–35 | AWS, VPC & Terraform                         |    ✅   |
| 🐳 Phase 3 |  36–50 | Docker, Security & CI/CD                     |    ✅   |
| 🤖 Phase 4 |  51–75 | Serverless & AI                              |    ✅   |
| ☸️ Phase 5 |  76–90 | Kubernetes, EKS & Observability              |    ✅   |
| 💼 Phase 6 | 91–100 | Capstone, Portfolio & Interview Preparation  |   🔄   |

**Current milestone: Phase 6 — Capstone build in progress (Project 5: Zedexa)**

---

# 🧭 What I'm Building

This journey is not just a collection of tutorials.

The goal is to gradually build the skills required to design, provision, deploy, secure, monitor, and explain cloud infrastructure — and, in the final phase, to tie every prior skill into one working platform.

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
Self-Service Platform (Capstone)
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

* VPC architecture, CIDR, public vs private subnets
* Route tables, Internet Gateway, NAT
* Bastion access, private EC2 networking
* Infrastructure as Code, Terraform state

---

## Project 2 — Containerized Application + CI/CD

**Focus:** Docker + GitHub Actions + Security

```text
Developer
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
   GitHub Container Registry
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

* Docker containerization, Python/Flask application
* Automated tests with Pytest, GitHub Actions CI/CD
* Trivy vulnerability scanning, GitHub Container Registry
* Immutable Git-SHA image tagging
* Application health checks (`/`, `/health`) and deployment verification

---

## Project 3 — Serverless AI Pipeline

**Focus:** AWS Lambda, Rekognition, DynamoDB, API Gateway

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

### Key capabilities

* Event-driven architecture — S3 upload triggers Lambda automatically, no server running idle
* boto3 for AWS service integration
* Rekognition for image analysis, results persisted to DynamoDB
* API Gateway exposing results via a REST endpoint
* IAM least-privilege execution roles, error handling for failed invocations

---

## Project 4 — EKS + Observability

**Focus:** Kubernetes, Amazon EKS, Prometheus/Grafana

### Core topics covered

* Kubernetes architecture — Pods, Deployments, Services, Ingress
* ConfigMaps, Secrets, Volumes
* Helm, kubectl, Amazon EKS cluster provisioning via Terraform

### Observability stack

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

Cluster was provisioned, the application deployed and load-tested, monitoring verified end-to-end, then torn down immediately after — following the same cost-safety and cleanup discipline used throughout this journey (see below).

---

## Project 5 — Zedexa: Self-Service Internal Developer Platform (Capstone)

**Focus:** Tying Projects 1–4 together into one working platform

The capstone project. Instead of another standalone demo, Zedexa is a self-service platform that **reuses the infrastructure patterns built across Projects 1–4**:

```text
Developer submits an app (name + Docker image)
        ↓
Rule-based Decision Engine recommends a target (EC2),
estimated cost, and a security checklist
        ↓
Developer confirms (or overrides)
        ↓
Isolated Terraform workspace provisions real AWS infrastructure
(VPC, Security Group, EC2 — reusing Project 1's networking pattern)
        ↓
EC2 user-data installs Docker and runs the container
(reusing Project 2's containerization pattern)
        ↓
Real HTTP health check confirms the app is live
        ↓
Service auto-registers with DevPulse — a separate real-time
monitoring platform, also self-built — for continuous uptime tracking
        ↓
Pause / Resume / Destroy — full lifecycle control, including a
stable Elastic IP so pausing doesn't break the app's URL
```

### What makes this the capstone, not just another project

* **Every stage of the Deployment Map is driven by a real backend signal** — a Terraform exit code, an AWS status check, a real HTTP response — never a timed animation.
* **Per-deployment Terraform state isolation**, so multiple deployments never corrupt each other.
* **Input validation and safe process spawning** (`child_process.spawn` with argument arrays, never string-concatenated shell commands) — closing the command-injection risk that comes with user input driving infrastructure provisioning.
* **Honest, documented scope decisions** — a `V2 Roadmap` in the project's own README explains what was deliberately left out (a Kubernetes orchestration target, GitHub-source builds) and why, rather than silently omitting them.

### Companion projects built to prove Zedexa is general-purpose

* **DevPulse** — a real-time service monitoring platform (MERN + Socket.IO), built independently and then integrated with Zedexa as its automatic monitoring layer.
* **TeChat** — a small real-time WebSocket chat app, Dockerized and deployed *through* Zedexa specifically to prove the platform works for genuinely interactive, continuously-connected workloads — not just static content.

---

# 🔐 Security & Cost-Safety Principles

Security and cost awareness are part of the learning process, carried through every project in this journey — including the capstone's input validation, safe process spawning, and Elastic-IP cost disclosure.

### AWS Safety Workflow

```text
STOP
  ↓
VERIFY
  ↓
PROCEED
```

Before AWS changes, I verify: region, resource, network exposure, security group rules, credentials/secrets, expected cost, and cleanup requirements.

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

The goal is to avoid leaving unnecessary compute resources running — and where something *does* stay running intentionally (like a live portfolio demo), it's monitored, billing-alarmed, and documented, not left unattended.

---

# 🧪 Engineering Practices

* Infrastructure as Code, Git version control, automated testing, CI/CD
* Containerization, vulnerability scanning, health checks, immutable image tagging
* Event-driven serverless architecture
* Kubernetes orchestration and cluster observability
* Input validation and injection-safe system process execution
* Architecture documentation, including honest scope/limitation disclosure
* AWS cost-safety checks, reproducible infrastructure

---

# 💼 Phase 6 — Portfolio & Interview Preparation

### Days 91–100

The final phase is not simply about learning more tools. It is about turning everything learned into **understanding that can be demonstrated and explained.**

* Project architecture explanations and troubleshooting scenarios for each of the 5 projects
* Cloud/DevOps interview question preparation
* Project walkthrough videos (recorded demos for Project 2, Project 4, and the Zedexa capstone)
* Resume preparation, GitHub portfolio cleanup
* Internship/job application phase

---

# 📊 Technology Stack

### Cloud
AWS · EC2 · VPC · S3 · Lambda · DynamoDB · API Gateway · Rekognition · EKS

### Infrastructure
Terraform · Terraform Modules · Terraform State · AWS Networking

### Containers
Docker · GitHub Container Registry

### CI/CD
GitHub Actions · Automated Testing · Security Scanning · Deployment Verification

### Security
IAM · Security Groups · Trivy · SSH security · Private networking · Input validation / injection-safe process execution

### Kubernetes
Kubernetes · EKS · kubectl · Helm

### Observability
Prometheus · Grafana · Alertmanager · DevPulse (self-built)

### Real-Time Systems
Socket.IO · WebSockets (`ws`)

### Development
Python · Flask · Node.js · Express · React · Git · GitHub

---

# 💻 Environment

| Tool       | Environment                          |
| ---------- | ------------------------------------- |
| OS         | CachyOS                               |
| AWS Region | Multi-region — see [Region Configuration Note](#-region-configuration-note) below |
| Git        | Installed                             |
| AWS CLI    | Installed                             |
| Terraform  | Installed                             |
| Docker     | Used throughout Phases 3–6            |
| GitHub     | Project repositories                  |

---

# 🌍 Region Configuration Note

This project spans two AWS regions — not a documentation mistake, verified below.

| Region | What ran here | Why |
|---|---|---|
| **`ap-south-1`** (Mumbai) | All active EC2 compute, S3 storage, Amazon Rekognition | AWS's original India region — used for everything except the EKS cluster |
| **`ap-south-2`** (Hyderabad) | The EKS cluster (Project 4) | Provisioned here during Phase 5, confirmed via AWS Health Event notifications and Cost Explorer's "Amazon Elastic Container Service for Kubernetes" line item |

**How this was verified, not just assumed:**
- `aws eks list-clusters --region ap-south-2` returns empty *today* — because the cluster was already destroyed, following this project's build → verify → destroy discipline (see Cost-Safety Principles above)
- An AWS Health Event — *"[Action Required] Amazon EKS Kubernetes 1.31 end of extended support [AP-SOUTH-2]"* — independently confirms a real cluster existed in that region
- AWS Cost Explorer's monthly cost breakdown shows real EKS charges in the months the cluster was active

**Why it's documented this way instead of picking one region:** an earlier draft of this README listed only `ap-south-2` as "the" region, which didn't match the live EC2 instances actually running in `ap-south-1`. Rather than guess or pick whichever sounded cleaner, every claim above was checked directly against AWS CLI output and the Billing Console before being written down — same verify-before-trusting habit this whole journey has tried to practice, applied to its own documentation.

---

# 📁 Repository Structure

```text
My-Cloud-Journey/
│
├── day-01/ ... day-50/
│
├── day-51/ ... day-75/        # Phase 4 — Serverless & AI
│
├── day-76/ ... day-90/        # Phase 5 — Kubernetes & EKS
│
├── day-91/ ... day-100/       # Phase 6 — Capstone & portfolio prep
│
├── project-1/                 # AWS VPC + Terraform
├── project-2/                 # Docker + CI/CD
├── project-3/                 # Serverless AI pipeline
├── project-4/                 # EKS + Observability
└── project-5-zedexa/          # Capstone — see separate repo: zedexa/
                                # Companion repos: devpulse/, techat/
```

---

# 🧠 Learning Philosophy

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

The goal is not to memorize commands. The goal is to understand **why the architecture works, how the components communicate, how to troubleshoot failures, and how to automate the same work reliably** — and, by the capstone, to combine that understanding into something that works end-to-end on its own.

---

# 📈 Journey Status

```text
Days 01–11   ████████████████████  Foundations
Days 12–35   ████████████████████  AWS + Terraform
Days 36–50   ████████████████████  Docker + CI/CD
Days 51–75   ████████████████████  Serverless + AI
Days 76–90   ████████████████████  Kubernetes + EKS
Days 91–100  ██████████░░░░░░░░░░  Capstone (Zedexa) + Portfolio
```

**Current milestone: Phase 6 — Zedexa capstone build, approaching Day 100**

---

# 🎯 End Goal

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
Tied together, by Day 100, into one working platform.
