# Day 59 — Lambda Cross-Region Integration

## 📌 Overview

Day 59 connected the existing **AWS Lambda function in `ap-south-2`** with **Amazon Rekognition in `ap-south-1`**.

The key implementation detail was explicitly specifying the Rekognition region in the Python `boto3` client.

---

## 🎯 Objectives

* Connect Lambda to Rekognition.
* Configure the Rekognition S3 bucket through an environment variable.
* Explicitly target `ap-south-1`.
* Configure the Lambda execution role.
* Resolve IAM authorization errors.
* Resolve S3 object access errors.

---

## 🏗️ Architecture

```text
                 AWS

       ap-south-2              ap-south-1
        Hyderabad                Mumbai
            │                       │
            │                       │
      ┌─────────────┐        ┌───────────────┐
      │   Lambda    │ boto3  │ Rekognition   │
      │             │───────>│ DetectLabels  │
      └──────┬──────┘        └───────┬───────┘
             │                       │
             ▼                       ▼
      CloudWatch Logs           S3 Test Bucket
```

---

## ⚙️ Step 1 — Configure Environment Variable

Lambda was configured with:

```text
REK_BUCKET_NAME
```

This avoids hard-coding the bucket name inside the application.

Conceptually:

```text
Environment Variable
        ↓
REK_BUCKET_NAME
        ↓
Lambda
        ↓
boto3
```

---

## 🐍 Step 2 — Configure boto3

The Rekognition client was explicitly configured for Mumbai:

```python
import os
import boto3

rekognition = boto3.client(
    "rekognition",
    region_name="ap-south-1"
)

def lambda_handler(event, context):
    rek_bucket = os.environ.get("REK_BUCKET_NAME")

    # Lambda execution logic
```

### Important Detail

Lambda itself remained in:

```text
ap-south-2
```

while the Rekognition client targeted:

```text
ap-south-1
```

This demonstrates that an AWS application can communicate with a service endpoint in another region when the service/API supports that architecture.

---

# 🔐 IAM Troubleshooting

Two important permission problems were encountered during integration.

---

## Problem 1 — `AccessDeniedException`

### Cause

The Lambda execution role did not have permission to call:

```text
rekognition:DetectLabels
```

### Resolution

A custom policy was attached:

```text
Day54-57-Rekognition-DetectLabels
```

This granted the Lambda execution role permission to call the required Rekognition API.

---

## Problem 2 — `InvalidS3ObjectException`

After Rekognition permissions were fixed, Rekognition still could not access the S3 object.

### Cause

The Lambda execution role required permission to read the image from S3.

### Resolution

The following AWS-managed policy was attached:

```text
AmazonS3ReadOnlyAccess
```

---

## 🔐 Final IAM Configuration

The Lambda execution role contained:

| Policy                              | Purpose                           |
| ----------------------------------- | --------------------------------- |
| `AWSLambdaBasicExecutionRole`       | CloudWatch logging                |
| `Day54-57-Rekognition-DetectLabels` | Rekognition `DetectLabels` access |
| `AmazonS3ReadOnlyAccess`            | Read image objects from S3        |

---

## 🧠 IAM Troubleshooting Pattern

The troubleshooting process followed:

```text
Lambda invokes Rekognition
        ↓
AccessDeniedException
        ↓
Check IAM
        ↓
Add DetectLabels permission
        ↓
Try again
        ↓
InvalidS3ObjectException
        ↓
Check S3 access
        ↓
Add S3 read permission
        ↓
Try again
```

This demonstrated an important AWS debugging principle:

> Fix the first authorization error, test again, then investigate the next failure.

---

## 📚 Concepts Learned

### 1. Environment Variables

Configuration such as bucket names should be separated from application logic when practical.

### 2. boto3 Regional Clients

AWS SDK clients can explicitly target a specific region:

```python
boto3.client("rekognition", region_name="ap-south-1")
```

### 3. Lambda Execution Role

Lambda does not automatically receive permission to access every AWS service.

The execution role determines what AWS APIs the function can call.

### 4. Least-Privilege Direction

The required permissions should correspond to the operations the application actually performs.

---

## ✅ Day 59 Result

* Lambda successfully configured to target Rekognition in `ap-south-1`.
* Rekognition bucket configured through an environment variable.
* Rekognition IAM permission added.
* S3 read permission added.
* `AccessDeniedException` resolved.
* `InvalidS3ObjectException` resolved.
* Lambda was ready for end-to-end testing.

---

## 🔑 Key Takeaway

> Cross-region integration requires both correct service configuration and correct IAM permissions. A successful AWS architecture depends on both.


