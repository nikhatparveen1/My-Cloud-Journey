# Day 61 — Error Handling & Edge Cases

## 📌 Overview

Day 61 focused on making the image-processing Lambda function more **reliable and fault-tolerant**.

The previous implementation successfully processed valid images, but unexpected conditions such as:

* Missing S3 objects
* Invalid object keys
* AWS API failures
* Unexpected runtime errors

could cause the Lambda execution to fail without providing enough diagnostic information.

To address this, the Lambda function was enhanced with **multi-level exception handling** and structured CloudWatch logging.

---

# 🎯 Objectives

* Handle AWS service errors gracefully.
* Handle missing or invalid S3 object keys.
* Prevent one bad record from stopping the processing of remaining records.
* Log useful diagnostic information to CloudWatch.
* Add a high-level safety net for unexpected runtime errors.
* Test both successful and failed image-processing scenarios.

---

# 🏗️ Error Handling Architecture

The Lambda function now follows a layered error-handling model:

```text
                     Lambda Invocation
                            │
                            ▼
                 ┌─────────────────────┐
                 │  Top-Level try      │
                 │  Unexpected Errors  │
                 └──────────┬──────────┘
                            │
                            ▼
                    Process S3 Records
                            │
                            ▼
                  Check Object Key
                     │          │
                   Valid       Missing
                     │          │
                     ▼          ▼
               Rekognition    Log Warning
                     │         + Skip
                     ▼
              ┌──────────────┐
              │ ClientError  │
              │ Handling     │
              └──────┬───────┘
                     │
              ┌──────┴──────┐
              ▼             ▼
           Success        AWS Error
              │             │
              ▼             ▼
        Log Labels      Log Error
                           │
                           ▼
                     Continue Record
```

---

# 🧠 Key Concepts Applied

## 1. Specific AWS API Error Handling

The Rekognition API call is wrapped in:

```python
try:
    response = rekognition.detect_labels(...)
except ClientError as error:
    ...
```

The Lambda function imports:

```python
from botocore.exceptions import ClientError
```

This allows AWS service exceptions to be handled separately from general Python exceptions.

---

## 2. Why `ClientError`?

AWS SDK operations can return structured service errors.

For example:

```text
InvalidS3ObjectException
AccessDeniedException
ResourceNotFoundException
```

Instead of treating all failures as generic Python errors, the function extracts:

```python
error_code = error.response["Error"]["Code"]
error_message = error.response["Error"]["Message"]
```

This produces more useful diagnostic information.

---

# 3. Missing Object-Key Validation

Before calling Rekognition, the function checks whether the event contains an S3 object key:

```python
key = record.get("s3", {}).get("object", {}).get("key")

if not key:
    print("Warning: Event record missing object key. Skipping record.")
    continue
```

This prevents the function from making an invalid Rekognition request.

---

# 4. Continue Processing Remaining Records

When Rekognition returns a `ClientError`, the function uses:

```python
continue
```

This is important when the Lambda event contains multiple records.

The processing model becomes:

```text
Record 1 → Success
Record 2 → Error → Log → Continue
Record 3 → Success
```

Instead of:

```text
Record 1 → Success
Record 2 → Error
             ↓
           STOP
             ↓
Record 3 never processed
```

---

# 5. Top-Level Exception Handling

The complete Lambda handler is also protected by:

```python
try:
    ...
except Exception as error:
    print(f"[CRITICAL] Unexpected Lambda execution error: {str(error)}")
    raise error
```

This acts as a final safety net for unexpected runtime problems.

### Why re-raise the exception?

The error is logged for diagnostics, but the exception is still re-raised so that Lambda/AWS monitoring can recognize the invocation as a failure when appropriate.

---

# 🐍 Code Implementation

## `lambda_function.py`

```python
import json
import os
import boto3
from botocore.exceptions import ClientError

rekognition = boto3.client(
    "rekognition",
    region_name="ap-south-1"
)


def lambda_handler(event, context):
    try:
        print("S3 event received:")
        print(json.dumps(event, indent=2))

        rek_bucket = os.environ.get("REK_BUCKET_NAME")

        for record in event.get("Records", []):

            event_bucket = record.get(
                "s3", {}
            ).get(
                "bucket", {}
            ).get(
                "name",
                rek_bucket
            )

            key = record.get(
                "s3", {}
            ).get(
                "object", {}
            ).get(
                "key"
            )

            # Validate object key
            if not key:
                print(
                    "Warning: Event record missing "
                    "object key. Skipping record."
                )
                continue

            # Select Rekognition-compatible bucket
            target_bucket = (
                event_bucket
                if "rekognition" in str(event_bucket)
                else rek_bucket
            )

            print(
                f"Calling Rekognition (ap-south-1) "
                f"for: s3://{target_bucket}/{key}"
            )

            try:
                response = rekognition.detect_labels(
                    Image={
                        "S3Object": {
                            "Bucket": target_bucket,
                            "Name": key
                        }
                    },
                    MaxLabels=10,
                    MinConfidence=80
                )

                print("--- Detected Labels ---")

                for label in response.get("Labels", []):
                    name = label["Name"]
                    confidence = label["Confidence"]

                    print(
                        f"  - {name}: {confidence:.2f}%"
                    )

            except ClientError as error:

                error_code = error.response[
                    "Error"
                ]["Code"]

                error_message = error.response[
                    "Error"
                ]["Message"]

                print(
                    f"[ERROR] Rekognition API "
                    f"ClientError ({error_code}): "
                    f"{error_message}"
                )

                continue

        return {
            "statusCode": 200,
            "body": "Image processing completed"
        }

    except Exception as error:

        print(
            f"[CRITICAL] Unexpected Lambda "
            f"execution error: {str(error)}"
        )

        raise error
```

---

# 🧪 Verification & Testing

Two different scenarios were tested.

---

## Test 1 — Valid S3 Object

### Input

```text
Bucket:
my-cloud-journey-rekognition-2026-4919

Object:
day58-dog.jpg
```

### Expected Behavior

```text
S3 Object
    ↓
Lambda
    ↓
Rekognition
    ↓
Detect Labels
    ↓
CloudWatch Logs
```

### Result

**Status: ✅ Success**

The function successfully detected seven labels:

```text
Animal
Canine
Dog
Mammal
Pet
Puppy
Golden Retriever
```

---

# 🧪 Test 2 — Non-Existent S3 Object

To test the error-handling path, a deliberately invalid object key was supplied:

```text
non-existent-image.jpg
```

The object did not exist in the S3 bucket.

---

## Expected Behavior

The Lambda function should:

1. Call Rekognition.
2. Receive `InvalidS3ObjectException`.
3. Catch the exception using `ClientError`.
4. Extract the AWS error code and message.
5. Write the diagnostic information to CloudWatch.
6. Continue execution instead of crashing at that point.

---

## CloudWatch Output

```text
Calling Rekognition (ap-south-1) for:
s3://my-cloud-journey-rekognition-2026-4919/non-existent-image.jpg

[ERROR] Rekognition API ClientError (InvalidS3ObjectException):
Unable to get object metadata from S3.
Check object key, region and/or access permissions.

END RequestId: aa9ba37a-ee06-48b0-ab00-3f4878dacc6d

REPORT RequestId: aa9ba37a-ee06-48b0-ab00-3f4878dacc6d
Duration: 67.41 ms
```

---

# 🔍 What This Test Proved

The invalid object did **not** cause an unhandled exception at the Rekognition layer.

Instead:

```text
Invalid S3 Object
       ↓
Rekognition Error
       ↓
ClientError
       ↓
Error Code Extracted
       ↓
Error Message Logged
       ↓
continue
```

This confirmed that the specific AWS API error-handling layer was working.

---

# 📊 Before vs After

## Before Day 61

```text
Lambda
  ↓
Rekognition
  ↓
AWS Error
  ↓
Unhandled Exception
  ↓
Execution Failure
```

## After Day 61

```text
Lambda
  ↓
Rekognition
  ↓
AWS Error
  ↓
ClientError
  ↓
Log Error Details
  ↓
Continue Processing
```

For unexpected errors:

```text
Unexpected Runtime Error
          ↓
    Top-Level Handler
          ↓
    Log Critical Error
          ↓
      Re-raise
```

---

# 🧠 Error Handling Layers

The implementation now has three practical protection points.

| Layer            | Purpose                         | Example                           |
| ---------------- | ------------------------------- | --------------------------------- |
| Input validation | Detect invalid event data       | Missing object key                |
| `ClientError`    | Handle AWS API failures         | `InvalidS3ObjectException`        |
| `Exception`      | Catch unexpected runtime errors | Unexpected Python/runtime failure |

---

# 📚 Important Concepts Learned

## Exception Handling

Python exceptions can be handled using:

```python
try:
    ...
except:
    ...
```

This prevents expected failures from immediately terminating the intended processing flow.

---

## AWS `ClientError`

`ClientError` provides access to structured AWS service error information.

Important fields include:

```text
Error.Code
Error.Message
```

---

## CloudWatch Logging

Useful logs make AWS troubleshooting significantly easier.

Instead of:

```text
Something failed
```

the function now produces:

```text
[ERROR]
Service: Rekognition
Error Code: InvalidS3ObjectException
Message: Unable to get object metadata...
```

---

## Graceful Failure

A robust cloud application should distinguish between:

```text
Expected/Recoverable Error
```

and:

```text
Unexpected/Critical Error
```

Expected AWS API errors can be logged and handled.

Unexpected errors are logged and re-raised.

---

# 🔐 Reliability Improvement

Day 61 improved the Lambda architecture from a basic working implementation into a more fault-tolerant application.

```text
                 Lambda
                   │
                   ▼
             Validate Input
                   │
                   ▼
             Call Rekognition
                   │
          ┌────────┴────────┐
          │                 │
       Success            Error
          │                 │
          ▼                 ▼
      Parse Labels      ClientError
          │                 │
          ▼                 ▼
      CloudWatch       Log Details
                            │
                            ▼
                         Continue
```

---

# ✅ Day 61 Verification Checklist

| Test / Component                    | Status |
| ----------------------------------- | ------ |
| Valid image processing              | ✅      |
| Rekognition API call                | ✅      |
| Label extraction                    | ✅      |
| Missing object-key validation       | ✅      |
| `ClientError` handling              | ✅      |
| `InvalidS3ObjectException` test     | ✅      |
| Error code logging                  | ✅      |
| Error message logging               | ✅      |
| Continue processing after API error | ✅      |
| Top-level exception handler         | ✅      |
| CloudWatch verification             | ✅      |

---

# 📈 Progress From Day 60 → Day 61

```text
Day 60
End-to-end Rekognition pipeline
        ↓
Day 61
Fault-tolerant processing
        ↓
Input validation
        ↓
AWS API error handling
        ↓
Unexpected error handling
        ↓
Better CloudWatch diagnostics
```

---

# 🎓 Final Learning Outcome

By the end of Day 61, the Lambda function was no longer designed only for the **happy path**.

It could now:

* Validate incoming event data.
* Detect missing object keys.
* Handle AWS `ClientError` exceptions.
* Identify specific AWS error codes.
* Log diagnostic information.
* Continue processing after recoverable record-level failures.
* Catch unexpected runtime errors.
* Preserve visibility through CloudWatch Logs.

---

## 🔑 Key Takeaway

> Production-quality cloud applications must be designed for failure, not only success. Validate inputs, handle expected AWS errors specifically, log useful diagnostics, and keep a final safety net for unexpected failures.
