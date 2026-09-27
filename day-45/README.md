# Day 45 — Deploy GHCR Docker Image to AWS EC2

## Goal

Deploy the exact Docker image produced by the CI pipeline
to an AWS EC2 instance.

## Deployment Flow

Developer
    ↓
git push
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
EC2
    ↓
docker pull
    ↓
Docker Container
    ↓
Flask Application

## Important Concept

Build once → store → deploy the same artifact.

The EC2 instance does not rebuild the application.

It pulls the already-built image from GHCR.

## AWS

Region:
ap-south-2

Instance:
t3.micro

Purpose:
Temporary application deployment

## Docker Commands

docker pull ghcr.io/<username>/my-cloud-journey:<sha>

docker run -d \
  --name my-cloud-journey \
  -p 5000:5000 \
  ghcr.io/<username>/my-cloud-journey:<sha>

docker ps

docker logs my-cloud-journey

docker stop my-cloud-journey

docker rm my-cloud-journey

## Verification

Local EC2 test:

curl http://localhost:5000

External test:

curl http://<PUBLIC_IP>:5000

## Security

SSH port 22:
Only my IP.

Application port 5000:
Temporarily public for learning.

GHCR authentication:
Use a token; never commit credentials.

## Main Lesson

CI produces the artifact.

GHCR stores the artifact.

EC2 pulls and runs the artifact.

## AWS Cost Safety

Only one temporary t3.micro is used.

No NAT Gateway.
No Load Balancer.
No RDS.
No EKS.
No additional EC2.

