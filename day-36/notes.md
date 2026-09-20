# Day 37 — Python Hello World Application

## Application

Built a small Flask web application.

Files:

- app.py
- requirements.txt
- Dockerfile
- .dockerignore

## Application Flow

Browser
    ↓
HTTP request
    ↓
Flask
    ↓
@app.route("/")
    ↓
Python function
    ↓
Response

## Port

The application listens on:

5000

## Important Flask Setting

host="0.0.0.0"

This allows the application to listen on all interfaces,
which is important when running inside a container.

## Dockerfile Flow

FROM
    ↓
WORKDIR
    ↓
COPY requirements.txt
    ↓
RUN pip install
    ↓
COPY app.py
    ↓
EXPOSE 5000
    ↓
CMD python app.py

## Important Concepts

RUN
→ executes during image build.

CMD
→ default process when container starts.

EXPOSE
→ documents the container port.

docker run -p
→ publishes/maps the container port to the host.

## Day 37 Result

The Python application works locally.

The Dockerfile has been prepared to package the
Python application into a Docker image.

Image build and container execution will be tested
on Day 38.

# Day 38 — Build and Run Dockerized Application

## Goal

Build the Python Flask application into a Docker image,
run it as a container, test it locally, and understand
Docker image tagging and registries.

## Build

Command:

docker build -t my-cloud-journey:day38 .

Meaning:

- docker build → build an image
- -t → assign name/tag
- . → current directory is build context

## Image

Image:

my-cloud-journey:day38

An image is the packaged application environment used
to create containers.

## Container

Container:

my-cloud-journey-container

Created from the Docker image.

## Port Mapping

docker run -p 5000:5000 ...

Meaning:

HOST PORT : CONTAINER PORT

5000 → 5000

Browser
    ↓
localhost:5000
    ↓
Docker host
    ↓
Container port 5000
    ↓
Flask

## Important Commands

docker build
→ Build image.

docker images
→ List images.

docker image inspect
→ Inspect image.

docker run
→ Create and start container.

docker ps
→ Show running containers.

docker ps -a
→ Show all containers.

docker logs
→ Show container logs.

docker top
→ Show processes inside container.

docker stop
→ Stop container.

docker start
→ Start existing stopped container.

docker rm
→ Remove container.

docker history
→ Show image layers.

docker tag
→ Give an image another tag/name.

docker push
→ Upload image to a registry.

## Image vs Container

Image
→ Reusable packaged artifact.

Container
→ Running/stopped instance created from an image.

## Registry

A registry stores Docker images.

Flow:

Local Docker Image
    ↓
docker push
    ↓
Registry
    ↓
docker pull
    ↓
Another machine

## Day 38 Result

The Flask application was packaged into a Docker image,
run inside a container, exposed through port 5000,
and prepared for registry-based distribution.

