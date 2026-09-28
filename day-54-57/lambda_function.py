import json


def lambda_handler(event, context):
    print("S3 event received:")
    print(json.dumps(event, indent=2))

    for record in event.get("Records", []):
        bucket = record["s3"]["bucket"]["name"]
        key = record["s3"]["object"]["key"]

        print(f"Bucket: {bucket}")
        print(f"Uploaded object: {key}")

    return {
        "statusCode": 200,
        "body": "S3 event processed successfully"
    }

