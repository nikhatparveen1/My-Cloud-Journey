# Day 64 — API Gateway HTTP API Setup

## Overview
Exposed an HTTP REST API (`day64-image-results-api`) to retrieve DynamoDB image results via `GET /results/{imageId}`.

## Architecture
* API Gateway HTTP API integrated with `day64-get-image-result` Lambda.
* API Lambda reads items directly from DynamoDB using `dynamodb:GetItem`.
