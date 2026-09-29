Day 62 — DynamoDB Table Creation

📌 Overview

Day 62 introduced Amazon DynamoDB into the image-analysis pipeline.

The goal was to create a serverless database for storing the structured results produced by Amazon Rekognition.

The DynamoDB table was successfully created, reached the ACTIVE state, and was verified by inserting and retrieving a test item.

🎯 Objectives

Create a DynamoDB table for image-analysis results.

Use imageKey as the partition key.

Use on-demand billing to keep the database serverless and cost-efficient.

Verify the table is operational.

Insert a test image-analysis record.

Retrieve the record using the AWS CLI.

🏗️ DynamoDB Configuration

Configuration

Value

Table Name

day54-57-image-results

Partition Key

imageKey

Key Type

String (S)

Billing Mode

PAY_PER_REQUEST

Region

ap-south-2

Purpose

Store Rekognition image-analysis results

🧠 Why DynamoDB?

The existing pipeline could detect image labels through Rekognition, but the results were primarily visible through CloudWatch Logs.

DynamoDB provides persistent structured storage:

Image
  ↓
S3
  ↓
Lambda
  ↓
Rekognition
  ↓
Detected Labels
  ↓
DynamoDB

This allows image-analysis results to be retrieved later instead of relying only on logs.

🗃️ Data Model

The table uses:

Partition Key
     │
     ▼
 imageKey

Example item:

{
    "imageKey": {
        "S": "test-dog.jpg"
    },
    "labels": {
        "S": "Dog, Animal, Pet"
    },
    "timestamp": {
        "S": "2026-09-29T18:00:00Z"
    }
}

Attribute Purpose

Attribute

Purpose

imageKey

Identifies the analyzed image

labels

Stores detected image labels

timestamp

Records when the result was stored

💰 Billing Mode

The table uses:

PAY_PER_REQUEST

This is also known as on-demand capacity mode.

It is appropriate for this learning project because capacity does not need to be manually provisioned in advance.

No fixed read/write capacity
          ↓
Pay for actual usage
          ↓
Serverless-friendly

🛠️ Verification

The table was created using the AWS CLI and verified until it reached:

ACTIVE

A test item was then inserted and retrieved successfully.

This confirmed that:

Create Table
     ↓
ACTIVE
     ↓
Put Item
     ↓
Get Item
     ↓
Data Retrieved Successfully

🧪 Test Item

The test record used:

imageKey: test-dog.jpg
labels: Dog, Animal, Pet
timestamp: 2026-09-29T18:00:00Z

The successful retrieval confirmed that the DynamoDB table was functioning correctly.

🧠 Concepts Learned

1. DynamoDB Partition Key

Every DynamoDB table requires a primary key.

For this project:

imageKey

was selected as the partition key because each image-analysis result can be associated with an image object key.

2. Serverless Database

DynamoDB works well with Lambda because both services are managed/serverless AWS components.

Lambda
   │
   ▼
DynamoDB

No database server needs to be provisioned or maintained.

3. On-Demand Capacity

PAY_PER_REQUEST allows the application to use DynamoDB without manually managing provisioned read/write capacity.

📈 Day 62 Progress

Before Day 62:

S3
 ↓
Lambda
 ↓
Rekognition
 ↓
CloudWatch Logs

After Day 62:

S3
 ↓
Lambda
 ↓
Rekognition
 ↓
CloudWatch Logs
 ↓
DynamoDB

DynamoDB is now ready to become the persistent storage layer for the image-analysis results.

✅ Day 62 Verification Checklist

Task

Status

DynamoDB table created

✅

Partition key configured

✅

PAY_PER_REQUEST enabled

✅

Region verified

✅

Table reached ACTIVE

✅

Test item inserted

✅

Test item retrieved

✅

🎓 Final Learning Outcome

By the end of Day 62, the project had introduced a persistent data-storage layer for Rekognition results.

The main concepts covered were:

DynamoDB tables

Partition keys

String attributes

On-demand billing

AWS CLI DynamoDB operations

put-item

get-item

Serverless database architecture

🔜 Day 63 — Connecting Lambda to DynamoDB

Day 63 extends the existing Lambda pipeline so that Rekognition results are automatically persisted into DynamoDB.

Target Architecture

                    ap-south-2
                 ┌──────────────┐
                 │    Lambda    │
                 └──────┬───────┘
                        │
                        │ boto3
                        ▼
                 ┌──────────────┐
                 │  DynamoDB    │
                 │ image-results │
                 └──────────────┘
                        ▲
                        │
              Store Rekognition Results
                        │
                        │
        ap-south-1      │
     ┌──────────────┐   │
     │ Rekognition  │───┘
     │ DetectLabels │
     └──────────────┘

🔐 Step 1 — Create DynamoDB IAM Policy

The Lambda execution role needs permission to write items to the DynamoDB table.

The planned permission follows the Principle of Least Privilege by granting:

dynamodb:PutItem

Create the policy file:

cd ~/My-Cloud-Journey/day-54-57

cat << 'EOF' > dynamodb-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem"
      ],
      "Resource": "*"
    }
  ]
}
EOF

Create the IAM policy:

aws iam create-policy \
  --policy-name Day54-57-DynamoDB-PutItem \
  --policy-document file://dynamodb-policy.json

Retrieve the policy ARN:

export DYNAMODB_POLICY_ARN=$(aws iam list-policies \
  --scope Local \
  --query "Policies[?PolicyName=='Day54-57-DynamoDB-PutItem'].Arn" \
  --output text)

Attach it to the Lambda execution role:

aws iam attach-role-policy \
  --role-name day54-57-lambda-role \
  --policy-arn "$DYNAMODB_POLICY_ARN"

Security note: Resource: "*" is broader than ideal for production. A production implementation should restrict the policy to the specific DynamoDB table ARN.

🐍 Step 2 — Update Lambda Code

The Lambda function will initialize a DynamoDB resource in ap-south-2:

dynamodb = boto3.resource(
    "dynamodb",
    region_name="ap-south-2"
)

The table name will be configurable through:

TABLE_NAME

The intended write operation is:

table.put_item(
    Item={
        "imageKey": key,
        "labels": labels_list,
        "timestamp": context.aws_request_id
    }
)

This connects the Rekognition result to DynamoDB persistence.

⚙️ Step 3 — Configure Lambda and Deploy

Update the Lambda environment variables:

aws lambda update-function-configuration \
  --function-name "$FUNCTION_NAME" \
  --environment "Variables={TABLE_NAME=$TABLE_NAME,REK_BUCKET_NAME=$REK_BUCKET_NAME}" \
  --region ap-south-2

Create the deployment package:

rm -f lambda_function.zip

zip lambda_function.zip lambda_function.py

Deploy the updated code:

aws lambda update-function-code \
  --function-name "$FUNCTION_NAME" \
  --zip-file fileb://lambda_function.zip \
  --region ap-south-2

🧪 Step 4 — End-to-End Test

Invoke Lambda using the existing test image:

aws lambda invoke \
  --function-name "$FUNCTION_NAME" \
  --region ap-south-2 \
  --payload "{\"Records\":[{\"s3\":{\"bucket\":{\"name\":\"$REK_BUCKET_NAME\"},\"object\":{\"key\":\"day58-dog.jpg\"}}}]}" \
  response.json

Inspect the Lambda response:

cat response.json

🔎 Step 5 — Verify DynamoDB

Retrieve the result using the image key:

aws dynamodb get-item \
  --table-name "$TABLE_NAME" \
  --key '{"imageKey":{"S":"day58-dog.jpg"}}' \
  --region ap-south-2

Expected flow:

Lambda Invocation
      ↓
S3 Event
      ↓
Rekognition
      ↓
Labels Extracted
      ↓
DynamoDB PutItem
      ↓
DynamoDB GetItem
      ↓
Stored Result Verified

⚠️ Important Day 63 Data-Model Note

The Day 62 test item represents labels as a DynamoDB String:

"Dog, Animal, Pet"

The planned Day 63 Lambda code uses:

labels_list = [
    {
        "name": name,
        "confidence": f"{confidence:.2f}%"
    }
]

and then stores:

"labels": labels_list

DynamoDB will therefore store labels as a List, not as a String.

This is intentional if the goal is to preserve both the label name and confidence value.

The Day 63 implementation should therefore verify the final DynamoDB item shape rather than assuming it will match the Day 62 test item's labels type.

🔑 Key Takeaway

Day 62 introduced persistent storage for the image-analysis pipeline. Day 63 will connect Lambda directly to DynamoDB so that Rekognition results are automatically stored instead of existing only in CloudWatch Logs.

