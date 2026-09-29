# Day 64 — API Gateway Integration & Result Retrieval

## Overview
Exposed an HTTP REST API using Amazon API Gateway that allows external consumers to retrieve image detection results stored in DynamoDB via a simple `GET /results/{imageId}` request.

## Architecture & Implementation
* **API Gateway:** HTTP API (`day64-image-results-api`) deployed in `ap-south-2`.
* **API Handler Lambda:** `day64-get-image-result` (`api_lambda.py`) with `dynamodb:GetItem` access.
* **Route:** `GET /results/{imageId}` mapped via proxy integration.

## End-to-End Verification
Executed live endpoint test:
```bash
curl "$API_ENDPOINT/results/day58-dog.jpg"

