# Day 66 — Serverless Reliability & Controlled Failure Testing

## Overview
Initiated the **Reliability and Observability** phase for the Serverless AI Image Recognition Pipeline. Conducted controlled failure testing by passing a non-existent S3 object payload to evaluate system resilience and CloudWatch log behavior.

---

## 📸 Proof of Execution & Observability

### 1. Baseline Success (Day 65 API Verification)
![Baseline Success](images/day66-baseline-success.png)

### 2. Controlled Failure Output (`InvalidS3ObjectException`)
![Failure Response](images/day66-failure-response.png)

### 3. CloudWatch Error Stack Trace Diagnosis
![CloudWatch Logs](images/day66-cloudwatch-logs.png)

---

````markdown
# Day 66 — Serverless Reliability & Failure Handling

## 📌 Overview

Day 66 marked the beginning of the **Reliability and Observability** phase of the Serverless AI Image Recognition Pipeline.

Until this point, the project had primarily focused on the **Happy Path**:

```text
Image Upload
     ↓
Rekognition
     ↓
Lambda
     ↓
DynamoDB
     ↓
API Gateway
     ↓
Successful Response
````

Day 66 introduced **controlled failure testing** to understand how the system behaves when an external dependency fails.

A deliberately non-existent S3 object was supplied to the processing Lambda. This allowed the failure path to be observed without modifying or damaging the existing infrastructure.

---

# 🎯 Goal

The main objectives of Day 66 were:

* Understand the difference between the Happy Path and Failure Path.
* Perform a controlled Lambda failure test.
* Observe how Rekognition handles a missing S3 object.
* Understand Lambda error propagation.
* Inspect CloudWatch Logs.
* Adapt CloudWatch log inspection to AWS CLI v1.
* Identify reliability and observability gaps in the current architecture.

---

# 🏗️ Existing Multi-Region Architecture

The current application spans two AWS regions.

```text
                         Serverless AI Pipeline

                         ap-south-1
                    ┌───────────────────┐
                    │                   │
                    │   S3 Bucket       │
                    │   Source Images   │
                    │                   │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │   Rekognition     │
                    │   DetectLabels     │
                    │                   │
                    └─────────┬─────────┘
                              │
                              │
                         Cross-Region
                              │
                              ▼

                         ap-south-2
                    ┌───────────────────┐
                    │      Lambda       │
                    │ day54-57-s3-logger│
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │    DynamoDB       │
                    │ image-results     │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │   API Gateway     │
                    │  GET /results/... │
                    └───────────────────┘
```

### Components

| Component          | Region       | Purpose                                       |
| ------------------ | ------------ | --------------------------------------------- |
| S3                 | `ap-south-1` | Stores source images                          |
| Amazon Rekognition | `ap-south-1` | Performs image analysis                       |
| Lambda             | `ap-south-2` | Processes images and coordinates the workflow |
| DynamoDB           | `ap-south-2` | Stores image-analysis results                 |
| API Gateway        | `ap-south-2` | Exposes results through an HTTP API           |

---

# 🧠 Core Reliability Concepts

## 1. Happy Path

The Happy Path represents the expected successful workflow.

```text
Valid Image
    ↓
S3
    ↓
Rekognition
    ↓
Labels Detected
    ↓
Lambda
    ↓
DynamoDB Write
    ↓
API Gateway
    ↓
200 OK
```

---

## 2. Failure Path

The Failure Path occurs when one of the required components cannot successfully complete its operation.

For example:

```text
Invalid / Missing S3 Object
          ↓
     Rekognition
          ↓
InvalidS3ObjectException
          ↓
       Lambda
          ↓
   Execution Failure
```

The purpose of Day 66 was to deliberately trigger this condition and observe the result.

---

## 3. Controlled Failure Testing

Instead of waiting for a real production failure, a known invalid input was deliberately introduced.

This is useful because it allows the system's behavior to be tested safely and predictably.

```text
Known Invalid Input
        ↓
Controlled Failure
        ↓
Observe System
        ↓
Identify Weaknesses
        ↓
Design Reliability Improvements
```

---

# 🧪 Practical Failure Test

## Step 1 — Create Controlled Failure Payload

A test event was created using a deliberately non-existent S3 object:

```text
day66-this-object-does-not-exist.jpg
```

The payload was stored in:

```text
day66-failure-event.json
```

### Payload

```json
{
  "Records": [
    {
      "s3": {
        "bucket": {
          "name": "my-cloud-journey-rekognition-2026-4919"
        },
        "object": {
          "key": "day66-this-object-does-not-exist.jpg"
        }
      }
    }
  ]
}
```

The bucket exists, but the specified object does not.

This makes it a controlled dependency failure.

---

# 🚀 Step 2 — Invoke Lambda

The processing Lambda was invoked using AWS CLI:

```bash
export FUNCTION_NAME="day54-57-s3-logger"

aws lambda invoke \
  --function-name "$FUNCTION_NAME" \
  --payload fileb://day66-failure-event.json \
  --region ap-south-2 \
  day66-failure-response.json
```

### AWS CLI v1 Note

The environment uses **AWS CLI v1**, so CLI v2-specific options such as:

```text
--cli-binary-format raw-in-base64-out
```

were not required.

The invocation was therefore performed using the CLI v1-compatible syntax above.

---

# 📄 Step 3 — Inspect Lambda Response

The Lambda response was inspected using:

```bash
cat day66-failure-response.json
```

The invocation returned a failure response containing:

```text
500
```

along with:

```text
InvalidS3ObjectException
```

and the underlying:

```text
ClientError
```

from Amazon Rekognition.

---

# 🔍 Failure Chain

The controlled failure demonstrated the following execution path:

```text
Lambda receives event
        ↓
Reads S3 bucket + object key
        ↓
Calls Rekognition
        ↓
Rekognition attempts to access S3 object
        ↓
Object does not exist
        ↓
InvalidS3ObjectException
        ↓
ClientError
        ↓
Lambda execution fails
        ↓
500 response
```

---

# 📊 Step 4 — Inspect CloudWatch Logs

Because the environment uses AWS CLI v1, CloudWatch Logs were inspected using:

```bash
aws logs filter-log-events \
  --log-group-name "/aws/lambda/$FUNCTION_NAME" \
  --start-time $(python3 -c 'import time; print(int((time.time() - 300) * 1000))') \
  --region ap-south-2 \
  --query 'events[].message' \
  --output text
```

### Why This Command?

AWS CLI v2 provides convenient commands such as:

```text
aws logs tail
```

The current environment uses AWS CLI v1, so:

```text
aws logs filter-log-events
```

was used instead.

The dynamic timestamp limits the search to approximately the previous five minutes.

---

# 🧪 Observed Failure

The controlled test produced:

```text
InvalidS3ObjectException
```

because Rekognition could not retrieve metadata for:

```text
day66-this-object-does-not-exist.jpg
```

This confirmed that the dependency failure reached the Lambda execution layer.

---

# ⚠️ Important Architectural Finding

The failure test exposed an important reliability characteristic of the current implementation.

An unhandled Rekognition exception can stop the Lambda execution before the downstream DynamoDB operation completes.

```text
Rekognition Failure
        ↓
Unhandled Exception
        ↓
Lambda Execution Stops
        ↓
DynamoDB Write Does Not Occur
```

This is acceptable for a controlled test, but it identifies an important area for improvement before considering the system production-ready.

---

# 💡 Important Takeaways & Architectural Gaps

## 1. Unhandled Exception Isolation

The Rekognition exception stopped execution immediately.

This demonstrated that external service failures can prevent downstream processing.

```text
Rekognition
     ↓
    FAIL
     ↓
Lambda stops
     ↓
DynamoDB write skipped
```

The test helped identify exactly where the failure propagates through the architecture.

---

## 2. Observability Gap

CloudWatch successfully recorded the failure and provided diagnostic information.

However, simply writing an error to CloudWatch does not automatically notify an administrator or upstream system.

Current state:

```text
Failure
   ↓
CloudWatch Logs
   ↓
Log Exists
```

Missing capability:

```text
Failure
   ↓
Detection
   ↓
Notification
   ↓
Operator / System Action
```

---

## 3. Missing Notification / Recovery Mechanism

The current architecture does not yet have a dedicated mechanism for handling failed processing events.

Potential future improvements include:

* Amazon SQS Dead Letter Queue (DLQ)
* Amazon SNS notifications
* Lambda exception handling
* Retry strategies
* Structured error logging
* CloudWatch alarms

---

# 🔄 Reliability Improvement Direction

The next stage of the project can evolve the architecture from:

```text
Failure
   ↓
Lambda Error
   ↓
CloudWatch Log
```

toward:

```text
Failure
   ↓
Lambda Error Handling
   ↓
Retry / DLQ
   ↓
CloudWatch Monitoring
   ↓
SNS Notification
   ↓
Operator / Recovery Process
```

---

# 🧠 Production Reliability Concepts

Day 66 introduced several concepts that are important when moving from a working prototype toward a production-oriented system.

### Error Handling

Applications should explicitly decide how expected service failures are handled.

### Observability

Logs should provide enough information to understand:

* What failed
* Where it failed
* Why it failed
* Which resource was involved

### Retry Strategy

Transient failures may be recoverable and can potentially be retried.

### Dead Letter Queue

Messages that repeatedly fail processing can be moved to a DLQ for later investigation or recovery.

### Alerting

Critical failures should be capable of generating notifications rather than existing only inside CloudWatch Logs.

---

# 📈 Day 66 Learning Progress

```text
Previous Days
     ↓
Successful Serverless Pipeline
     ↓
Day 66
Controlled Failure Testing
     ↓
Failure Observed
     ↓
CloudWatch Diagnostics
     ↓
Reliability Gaps Identified
     ↓
Future Retry / DLQ / Alerting Design
```

---

# ✅ Day 66 Verification Checklist

| Test / Component                     | Status |
| ------------------------------------ | ------ |
| Existing architecture reviewed       | ✅      |
| Happy Path identified                | ✅      |
| Failure Path identified              | ✅      |
| Controlled invalid S3 object created | ✅      |
| Failure payload created              | ✅      |
| Lambda failure invocation            | ✅      |
| `InvalidS3ObjectException` observed  | ✅      |
| `500` failure response observed      | ✅      |
| CloudWatch Logs inspected            | ✅      |
| AWS CLI v1 logging method verified   | ✅      |
| Error propagation understood         | ✅      |
| Reliability gap identified           | ✅      |
| Notification/recovery gap identified | ✅      |

---

# 🎓 Final Learning Outcome

By the end of Day 66, the project moved beyond simply proving that the serverless pipeline works.

The system was deliberately tested under failure conditions to understand:

* How external AWS service failures propagate.
* How Lambda behaves when an exception is not handled.
* How CloudWatch provides failure visibility.
* Why observability alone is not enough.
* Why production systems require retry, recovery, and notification mechanisms.

The controlled failure test provided the foundation for the next reliability improvements.

---

# 🔑 Key Takeaway

> A production serverless system must be designed for both success and failure. Testing only the Happy Path proves that the system works; controlled failure testing reveals how the system behaves when something goes wrong.

```text
SUCCESS
  ↓
Process
  ↓
Persist
  ↓
Respond

FAILURE
  ↓
Detect
  ↓
Handle
  ↓
Retry / DLQ
  ↓
Alert
  ↓
Recover
```

---

# 🔜 Next Reliability Steps

Future improvements can include:

1. Add explicit Boto3 `ClientError` handling.
2. Decide which failures should be retried.
3. Introduce an SQS Dead Letter Queue.
4. Add SNS-based failure notifications.
5. Improve structured CloudWatch logging.
6. Add CloudWatch alarms for repeated failures.
7. Re-test both Happy Path and Failure Path after implementing the reliability layer.

````


