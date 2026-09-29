
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
