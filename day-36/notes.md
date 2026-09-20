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

