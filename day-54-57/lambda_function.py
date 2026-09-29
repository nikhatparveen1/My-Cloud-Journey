import json
import os
import boto3
from decimal import Decimal
from botocore.exceptions import ClientError

# Rekognition client points explicitly to ap-south-1 (Mumbai)
rekognition = boto3.client("rekognition", region_name="ap-south-1")

# DynamoDB resource targets ap-south-2 (Hyderabad)
dynamodb = boto3.resource("dynamodb", region_name="ap-south-2")
table = dynamodb.Table(os.environ["TABLE_NAME"])


def lambda_handler(event, context):
    print("Received event:", json.dumps(event))

    # Retrieve S3 bucket name directly from Lambda environment variable
    rek_bucket_name = os.environ["REK_BUCKET_NAME"]

    # Extract object key from S3 event or test payload
    image_key = event.get("image") or event.get("key")

    if not image_key and "Records" in event:
        image_key = event["Records"][0]["s3"]["object"]["key"]

    if not image_key:
        return {"statusCode": 400, "body": "Missing image key"}

    try:
        # Call Rekognition in ap-south-1
        response = rekognition.detect_labels(
            Image={
                "S3Object": {
                    "Bucket": rek_bucket_name,
                    "Name": image_key
                }
            },
            MaxLabels=10,
            MinConfidence=80
        )

        # Format labels into list of dictionaries
        labels = [
            {
                "name": label["Name"],
                "confidence": Decimal(str(round(label["Confidence"], 2)))
            }
            for label in response.get("Labels", [])
        ]

        # Write item to DynamoDB matching exact required structure
        table.put_item(
            Item={
                "imageKey": image_key,
                "labels": labels,
                "timestamp": context.aws_request_id
            }
        )
        print(f"Successfully saved results for {image_key} into DynamoDB.")

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Labels saved successfully", "imageKey": image_key})
        }

    except ClientError as e:
        print(f"AWS ClientError: {e.response['Error']['Message']}")
        return {"statusCode": 500, "body": str(e)}

