import json
import os
import boto3

# Explicitly call Rekognition in ap-south-1 (Mumbai)
rekognition = boto3.client("rekognition", region_name="ap-south-1")

def lambda_handler(event, context):
    print("S3 event received:")
    print(json.dumps(event, indent=2))

    rek_bucket = os.environ.get("REK_BUCKET_NAME")

    for record in event.get("Records", []):
        event_bucket = record.get("s3", {}).get("bucket", {}).get("name", rek_bucket)
        key = record.get("s3", {}).get("object", {}).get("key", "day58-dog.jpg")

        target_bucket = event_bucket if "rekognition" in str(event_bucket) else rek_bucket

        print(f"Calling Rekognition (ap-south-1) for: s3://{target_bucket}/{key}")

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
            print(f"  - {name}: {confidence:.2f}%")

    return {
        "statusCode": 200,
        "body": "Image analyzed successfully"
    }
