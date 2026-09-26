# Day 44 — Automated Docker Image Publishing

## Goal

Automate Docker image publishing through GitHub Actions.

## Pipeline

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
Trivy Security Scan
    ↓
GHCR Login
    ↓
Docker Push
    ↓
GitHub Container Registry

## Important Concepts

Container Registry
→ Stores Docker/OCI container images.

GHCR
→ GitHub Container Registry.

Artifact
→ A build output that can be stored and used later.

Image Tag
→ Identifies a particular version of a container image.

Git SHA
→ Allows the image to be connected to the exact
source-code commit that produced it.

GITHUB_TOKEN
→ GitHub-provided temporary authentication token
for workflow operations.

Least Privilege
→ Give the workflow only the permissions it needs.

## Important Workflow Permissions

contents: read
→ Allows the workflow to read repository contents.

packages: write
→ Allows the workflow to publish packages/images.

## Pipeline Security

Tests
    ↓
Docker Build
    ↓
Trivy Scan
    ↓
Only successful images are pushed.

## Important Commands

docker build -t my-cloud-journey:day44 day-38

docker run -d \
  --name day44-test \
  -p 5000:5000 \
  my-cloud-journey:day44

curl http://localhost:5000

docker stop day44-test

docker rm day44-test

git status

git diff --check

git add .

git commit

git push

## Main Lesson

Day 42:
Automated testing and Docker build.

Day 43:
Automated security scanning.

Day 44:
Automated image publishing.

The image becomes a reusable deployment artifact.

## AWS Cost Safety

No AWS infrastructure is required for Day 44.

Do not recreate the Day 39 EC2.
