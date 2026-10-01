# Day 76 — Kubernetes Core Objects

## Goal

Started Project 4 by learning the three fundamental
Kubernetes objects used by the roadmap:

- Pods
- Deployments
- Services

## Pod

A Pod is Kubernetes' smallest deployable unit.

## Deployment

A Deployment manages the desired number of Pod replicas
and replaces Pods when necessary.

## Service

A Service provides stable networking to a group of Pods
selected using labels.

## Architecture

Deployment
  ↓
Pods
  ↓
Service

## Screenshots & Proof

### 1. Pod Manifest (`pod.yaml`)
![Pod Manifest](screenshots/Screenshot%20From%202026-10-01%2016-58-22.png)

### 2. Deployment Manifest (`deployment.yaml`)
![Deployment Manifest](screenshots/Screenshot%20From%202026-10-01%2016-58-47.png)

### 3. Service Manifest (`service.yaml`)
![Service Manifest](screenshots/Screenshot%20From%202026-10-01%2016-59-03.png)

### 4. Manifest Syntax Validation
![Syntax Validation](screenshots/Screenshot%20From%202026-10-01%2016-59-33.png)

## AWS Safety

No EKS cluster was created on Day 76.

Kubernetes concepts were studied before starting
paid EKS infrastructure.
