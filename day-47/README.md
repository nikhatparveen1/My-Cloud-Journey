# Day 47 — CI/CD Refinement

## Goal

Refine Project 2 so that the CI/CD process clearly separates
validation, artifact creation, registry storage, deployment,
and health verification.

## Project Flow

Developer
    ↓
git push
    ↓
GitHub Actions
    ↓
Tests
    ↓
Security Scan
    ↓
Docker Build
    ↓
GHCR
    ↓
Deployment
    ↓
AWS EC2
    ↓
Docker Container
    ↓
Health Check

## CI

Continuous Integration validates the code.

CI includes:

- Tests
- Lint
- Security scanning
- Docker build

## CD

Continuous Deployment/Delivery moves the validated artifact
to the runtime environment.

Flow:

GHCR
 ↓
EC2
 ↓
Docker
 ↓
Application
 ↓
Health Check

## Important Principle

Build once → scan once → store → deploy the same artifact.

The EC2 server should not rebuild the application.

## Image Identity

Use the Git commit SHA to identify the Docker image.

Example:

ghcr.io/<username>/my-cloud-journey:<SHA>

The SHA connects:

Git commit
 ↓
Docker image
 ↓
GHCR
 ↓
EC2 deployment

## Verification

docker ps

docker images

docker inspect my-cloud-journey \
  --format '{{.Config.Image}}'

docker logs my-cloud-journey

curl http://localhost:5000

## AWS

Region:
ap-south-2

Existing deployment:
day-45-deploy

Instance type:
t3.micro

No additional infrastructure created.

## Main Lesson

CI answers:

"Is the application ready to deploy?"

CD answers:

"Can the validated artifact be delivered to the runtime environment?"

The same Docker artifact should move through the pipeline.

