# Day 42 — GitHub Actions CI

## Goal

Automate application verification using GitHub Actions.

## CI Flow

Developer
    ↓
git push
    ↓
GitHub
    ↓
GitHub Actions
    ↓
Checkout
    ↓
Python setup
    ↓
Install dependencies
    ↓
Run tests
    ↓
Build Docker image
    ↓
CI result

## Important Concepts

CI
→ Continuous Integration.

GitHub Actions
→ Automation platform integrated with GitHub.

Workflow
→ YAML file describing automated tasks.

Runner
→ Temporary machine that executes the workflow.

Job
→ Group of steps executed by a runner.

Step
→ Individual command or action in a job.

## Important File

.github/workflows/ci.yml

## Important Commands

git status
git add .
git commit
git push

Local Docker test:

docker build -t my-cloud-journey .
docker run -d --name day42-test -p 5000:5000 my-cloud-journey
curl http://localhost:5000
docker stop day42-test
docker rm day42-test

## Main Lesson

Manual process:

Developer
→ build
→ test
→ verify

CI process:

Developer
→ git push
→ GitHub Actions
→ build
→ test
→ result

CI reduces manual verification and catches problems early.

## AWS Cost Safety

Day 42 does not require a new EC2 instance.

The temporary Day 39 EC2 was already destroyed during Day 41.

