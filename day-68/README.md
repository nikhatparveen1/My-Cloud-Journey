# Day 68 — Serverless Observability

## Concepts

- CloudWatch Logs
- Lambda metrics
- Invocations
- Errors
- Duration
- Throttles
- Structured application logging
- Failure investigation

## Observability Model

Logs:
"What happened?"

Metrics:
"How often/how much?"

## Practical Work

Inspected Lambda CloudWatch logs after both
successful and failed executions.

## Architecture

S3
 ↓
Lambda
 ↓
Rekognition
 ↓
DynamoDB

CloudWatch observes the Lambda execution path.


---

## 📸 Proof of Execution

![Day 68 CloudWatch Logs](images/day68-cloudwatch-logs.png)
![Day 68 Lambda Metrics Part 1](images/day68-lambda-metrics-1.png)
![Day 68 Lambda Metrics Part 2](images/day68-lambda-metrics-2.png)
