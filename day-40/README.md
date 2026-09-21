# Day 40 — Run Dockerized Application on AWS EC2

## Goal

Operate and verify the Dockerized Flask application
on the EC2 infrastructure created with Terraform.

## Architecture

Laptop
  ↓
Internet
  ↓
AWS EC2
  ↓
Docker
  ↓
Flask Container
  ↓
Port 5000

## Important Commands

Check Docker:

docker --version

Check Docker service:

sudo systemctl status docker

List images:

docker images

List running containers:

docker ps

List all containers:

docker ps -a

View logs:

docker logs <container>

Follow logs:

docker logs -f <container>

Inspect container:

docker inspect <container>

Check port mapping:

docker port <container>

Stop:

docker stop <container>

Start:

docker start <container>

Restart:

docker restart <container>

## Important Concepts

docker ps
→ Shows running containers.

docker ps -a
→ Shows running and stopped containers.

docker stop
→ Stops a container without deleting it.

docker start
→ Starts a stopped container.

docker restart
→ Restarts a container.

docker logs
→ Helps troubleshoot application/container behaviour.

Port mapping:

EC2 port 5000
      ↓
Container port 5000

## Verification

Local EC2 test:

curl http://localhost:5000

External test:

curl http://<EC2_PUBLIC_IP>:5000

Expected:

Hello from My Cloud Journey!

## Main Lesson

Terraform provisions the infrastructure.

Docker packages and runs the application.

AWS networking allows external traffic to reach the application.

