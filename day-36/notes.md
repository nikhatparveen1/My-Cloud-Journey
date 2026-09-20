nano notes.md# Day 36 — Docker Basics

## Goal

Understand Docker images, containers, Dockerfiles,
and the basic Docker lifecycle.

## Image

A Docker image is a reusable package/template used
to create containers.

Example:

hello-world
day-36-demo

## Container

A container is a running or stopped instance created
from a Docker image.

## Dockerfile

A Dockerfile contains instructions used to build
a Docker image.

Example:

FROM alpine:latest

CMD ["echo", "Hello from my Day 36 Docker image!"]

## Docker Lifecycle

Dockerfile
    ↓
docker build
    ↓
Image
    ↓
docker run
    ↓
Container
    ↓
Application process

## Important Commands

docker --version
→ Check Docker CLI version.

docker info
→ Show Docker Engine information.

docker images
→ List local images.

docker ps
→ List running containers.

docker ps -a
→ List all containers.

docker build
→ Build an image.

docker run
→ Create and start a container.

docker logs
→ View container output.

docker stop
→ Stop a running container.

docker rm
→ Remove a container.

docker rmi
→ Remove an image.

## Key Difference

Image = reusable package/template.

Container = instance created from an image.

## Important Lesson

A container can exit normally when its main process
finishes. An exited container is not necessarily an error.

## Project 2

Day 36 begins the Docker + CI/CD project.

Later:

Docker
→ Application
→ Registry
→ EC2
→ GitHub Actions
→ Automated deployment

