import json
import os
import boto3
from decimal import Decimal
from botocore.exceptions import ClientError

# Initialize AWS SDK clients
rekognition = boto3.client('rekognition', region_name='ap-south-1')
dynamodb = boto3.resource('dynamodb', region_name='ap-south-2')

TABLE_NAME = os.environ.get('TABLE_NAME', 'day54-57-image-results')
REK_BUCKET_NAME = os.environ.get('REK_BUCKET_NAME', 'my-cloud-journey-rekognition-2026-4919')

table = dynamodb.Table(TABLE_NAME)

def lambda_handler(event, context):
    try:
        # Extract object key from S3 event trigger or direct payload
        record = event['Records'][0]
        image_key = record['s3']['object']['key']
        
        print(f"Processing image: {image_key}")

        # Call Rekognition to detect labels
        print(f"Calling Rekognition for bucket: {REK_BUCKET_NAME}, key: {image_key}")
        response = rekognition.detect_labels(
            Image={
                'S3Object': {
                    'Bucket': REK_BUCKET_NAME,
                    'Name': image_key
                }
            },
            MaxLabels=10,
            MinConfidence=80
        )

        labels = [
            {
                "name": label["Name"],
                "confidence": Decimal(str(round(label["Confidence"], 2)))
            }
            for label in response.get("Labels", [])
        ]
        
        print(f"Detected {len(labels)} labels for {image_key}")

        # Write item to DynamoDB
        print(f"Writing result to DynamoDB: {image_key}")
        table.put_item(
            Item={
                "imageKey": image_key,
                "labels": labels,
                "timestamp": context.aws_request_id
            }
        )
        print(f"Successfully stored result: {image_key}")

        # APPLICATION LOG MARKER: SUCCESS
        print(f"APPLICATION_SUCCESS image={image_key}")

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Labels saved successfully", "imageKey": image_key})
        }

    except ClientError as e:
        error_code = e.response['Error']['Code']
        error_msg = e.response['Error']['Message']
        print(f"ERROR: AWS ClientError ({error_code}) processing image: {error_msg}")

        # APPLICATION LOG MARKER: FAILURE
        print(f"APPLICATION_ERROR image={image_key} error={error_msg}")

        return {
            "statusCode": 500,
            "body": json.dumps({
                "error": error_code,
                "message": error_msg
            })
        }
    except Exception as e:
        print(f"ERROR: Unexpected error processing request: {str(e)}")
        
        # APPLICATION LOG MARKER: UNEXPECTED FAILURE
        print(f"APPLICATION_ERROR image=unknown error={str(e)}")

        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Internal Error", "details": str(e)})
        }
