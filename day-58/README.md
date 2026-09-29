# Day 58 — Direct Rekognition CLI Verification

## 📌 Overview

Day 58 focused on testing **Amazon Rekognition independently from Lambda**.

The purpose was to verify that the Rekognition service itself worked correctly before introducing Lambda into the architecture.

This created a clean troubleshooting approach:

```text
S3
 ↓
Rekognition CLI
 ↓
Verify service
 ↓
Lambda integration later
```

---

## 🎯 Objectives

* Upload a test image to the `ap-south-1` S3 bucket.
* Call Rekognition directly using AWS CLI.
* Verify that `DetectLabels` works.
* Save the API response as JSON.
* Confirm that the issue was not with Rekognition itself before integrating Lambda.

---

## 📦 Test Image

Test image:

```text
dog.jpg
```

The image was uploaded to:

```text
s3://$REK_BUCKET_NAME/day58-dog.jpg
```

---

## ⬆️ Step 1 — Upload Test Image

```bash
aws s3 cp \
  "$HOME/Downloads/dog.jpg" \
  "s3://$REK_BUCKET_NAME/day58-dog.jpg" \
  --region ap-south-1
```

This placed the image inside the Rekognition-compatible S3 bucket.

---

## 🔎 Step 2 — Run Rekognition

```bash
aws rekognition detect-labels \
  --region ap-south-1 \
  --image "{\"S3Object\":{\"Bucket\":\"$REK_BUCKET_NAME\",\"Name\":\"day58-dog.jpg\"}}" \
  --max-labels 10 \
  --min-confidence 80 \
  > day58-rekognition-output.json
```

### Command Breakdown

| Option                | Purpose                                 |
| --------------------- | --------------------------------------- |
| `aws rekognition`     | Access Amazon Rekognition               |
| `detect-labels`       | Detect objects/scenes in an image       |
| `--region ap-south-1` | Use Mumbai Rekognition endpoint         |
| `S3Object`            | Tell Rekognition where the image is     |
| `--max-labels 10`     | Return up to 10 labels                  |
| `--min-confidence 80` | Only return labels with ≥80% confidence |
| `>`                   | Save output to a JSON file              |

---

## 📄 Output File

The response was saved as:

```text
day58-rekognition-output.json
```

This provided a persistent record of the Rekognition API response.

---

## ✅ Detected Labels

The test returned labels including:

```text
Animal             100%
Canine             100%
Dog                100%
Golden Retriever    97.86%
```

---

## 🧪 Why Direct CLI Testing Was Important

Lambda had not yet been introduced into this test.

Therefore, the architecture was:

```text
Local Machine
     │
     │ AWS CLI
     ▼
Amazon Rekognition
     │
     ▼
S3 Test Bucket
```

This isolated the Rekognition component.

If the CLI test failed:

```text
Problem → Region / S3 / Rekognition
```

If the CLI test succeeded but Lambda failed:

```text
Problem → Lambda / IAM / boto3 / configuration
```

This is an important cloud troubleshooting technique.

---

## 🧠 Concepts Learned

### Service Isolation

Test one component independently before adding additional components.

### API Validation

Before debugging application code, verify that the underlying AWS API works directly.

### Confidence Threshold

`--min-confidence 80` limits results to labels with at least 80% confidence.

---

## ✅ Day 58 Result

* Test image successfully uploaded.
* Rekognition `DetectLabels` API successfully executed.
* JSON response successfully generated.
* Animal/dog-related labels detected.
* Rekognition service independently verified.

---

## 🔑 Key Takeaway

> Before debugging Lambda integration, verify the underlying AWS service directly. This separates service-level problems from application-level problems.

