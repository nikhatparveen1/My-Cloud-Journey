# Day 46 — Deployment Verification

## Goal

Verify that the exact Docker image produced by CI
is running successfully on AWS EC2.

## Complete Flow

Developer
    ↓
GitHub
    ↓
GitHub Actions
    ↓
Tests
    ↓
Docker Build
    ↓
Trivy
    ↓
GHCR
    ↓
docker pull
    ↓
AWS EC2
    ↓
Docker Container
    ↓
Flask
    ↓
Port 5000
    ↓
Internet

## Verification Commands

AWS:

aws ec2 describe-instances ...

EC2:

docker --version
docker ps
docker images
docker logs my-cloud-journey
docker port my-cloud-journey
docker stats --no-stream my-cloud-journey

Application:

curl http://localhost:5000

From laptop:

curl http://<PUBLIC_IP>:5000

Networking:

ss -tuln
ss -tuln | grep 5000

## Important Concepts

Image
→ Immutable application artifact/template.

Container
→ Running instance of an image.

GHCR
→ Container registry storing Docker images.

docker pull
→ Downloads an image from a registry.

docker run
→ Creates and starts a container.

Port mapping
→ Connects an EC2 host port to a container port.

Security Group
→ Controls network traffic reaching EC2.

## Troubleshooting Model

Application fails locally:
→ Check container/application/logs.

localhost works but public IP fails:
→ Check Security Group/networking/port mapping.

Container missing:
→ Check docker ps and docker ps -a.

Image missing:
→ Check docker images and docker pull.

GHCR pull fails:
→ Check authentication, permissions, image name and tag.

## Main Lesson

Do not simply ask:

"Is EC2 running?"

Verify every layer:

EC2
→ Docker
→ Image
→ Container
→ Application
→ Port
→ Network
→ External access

## AWS Cost Safety

Use the existing Day 45 EC2.

Do not create another EC2.

No NAT Gateway.
No RDS.
No Load Balancer.
No EKS.
No extra infrastructure.

