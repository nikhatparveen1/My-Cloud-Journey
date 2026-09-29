# Day 57 — Regional Diagnosis & Infrastructure Setup

## 📌 Overview

Day 57 focused on diagnosing a regional compatibility issue encountered while integrating **Amazon Rekognition** with the existing AWS architecture.

The primary infrastructure was already running in **`ap-south-2` (Hyderabad)**. During investigation, it became necessary to verify whether Amazon Rekognition was available in the same region and whether the existing S3 bucket could be used as the Rekognition image source.

Instead of modifying the existing infrastructure, a **separate test S3 bucket** was created in `ap-south-1` (Mumbai) for Rekognition testing.

---

## 🎯 Objectives

* Identify why Rekognition requests could not be performed from `ap-south-2`.
* Verify the region of the existing S3 bucket.
* Understand the regional relationship between S3 and Rekognition.
* Preserve the existing `ap-south-2` infrastructure.
* Create an isolated S3 bucket for Rekognition testing.

---

## 🔍 Problem Identified

The existing architecture used:

```text
Primary AWS Region
└── ap-south-2 (Hyderabad)
    └── Existing S3 Bucket
```

During testing, Amazon Rekognition was found to require a supported regional endpoint.

The existing S3 bucket was located in `ap-south-2`, while the Rekognition testing environment was moved to `ap-south-1`.

### Important Concept

For this workflow, the S3 object used by Rekognition must be accessible in the region associated with the Rekognition request.

Therefore, a dedicated test bucket was created in `ap-south-1`.

---

## 🧪 Investigation

### Step 1 — Check Existing S3 Bucket Region

```bash
aws s3api get-bucket-location \
  --bucket "my-cloud-journey-day54-2026"
```

The existing bucket was confirmed to be located in:

```text
ap-south-2
```

---

## 🏗️ Infrastructure Change

A separate S3 bucket was created in:

```text
ap-south-1
```

The existing `ap-south-2` bucket was intentionally left untouched.

### Create Test Bucket

```bash
export REK_BUCKET_NAME="my-cloud-journey-rekognition-2026-$RANDOM"

aws s3api create-bucket \
  --bucket "$REK_BUCKET_NAME" \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1
```

---

## 🗺️ Architecture

```text
                 AWS Infrastructure

        ap-south-2                    ap-south-1
         Hyderabad                      Mumbai
             │                             │
             │                             │
   ┌──────────────────┐          ┌──────────────────┐
   │ Existing S3      │          │ Rekognition Test │
   │ Bucket           │          │ S3 Bucket        │
   │                  │          │                  │
   │ Untouched        │          │ REK_BUCKET_NAME  │
   └──────────────────┘          └──────────────────┘
```

---

## 🧠 Concepts Learned

### 1. AWS Regional Availability

Not every AWS service is available in every AWS region.

Therefore:

```text
AWS Service
     ↓
Check regional availability
     ↓
Choose supported region
```

### 2. Cross-Region Architecture

Different AWS services can operate in different regions, but the integration must respect the service's regional requirements.

### 3. Isolation During Troubleshooting

Instead of modifying working infrastructure:

```text
Existing Infrastructure
        ↓
      Preserve
        ↓
Create isolated test resources
        ↓
Test independently
```

This reduces the risk of accidentally breaking previously completed work.

---

## ✅ Day 57 Result

* Existing `ap-south-2` S3 bucket verified.
* Rekognition-compatible test region selected.
* Dedicated S3 bucket created in `ap-south-1`.
* Existing infrastructure remained unchanged.
* Cross-region Rekognition architecture established for the next stage.

---

## 🔑 Key Takeaway

> When an AWS service is unavailable or incompatible in the primary region, first verify regional availability before changing existing infrastructure.

---
