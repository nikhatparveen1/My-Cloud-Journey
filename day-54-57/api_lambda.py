import json
import os
import boto3
from decimal import Decimal
from botocore.exceptions import ClientError

# Custom JSON Encoder for DynamoDB Decimal types
class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Decimal):
            return float(obj)
        return super(DecimalEncoder, self).default(obj)

dynamodb = boto3.resource("dynamodb", region_name="ap-south-2")

def lambda_handler(event, context):
    print("Received API event:", json.dumps(event))

    table_name = os.environ.get("TABLE_NAME", "day54-57-image-results")
    table = dynamodb.Table(table_name)

    # Extract imageId safely from pathParameters
    path_params = event.get("pathParameters") or {}
    image_id = path_params.get("imageId")

    if not image_id:
        return {
            "statusCode": 400,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"error": "Missing imageId path parameter"})
        }

    try:
        response = table.get_item(Key={"imageKey": image_id})
        item = response.get("Item")

        if not item:
            return {
                "statusCode": 404,
                "headers": {"Content-Type": "application/json"},
                "body": json.dumps({"error": f"Image result for '{image_id}' not found"})
            }

        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps(item, cls=DecimalEncoder)
        }

    except ClientError as e:
        print(f"DynamoDB ClientError: {str(e)}")
        return {
            "statusCode": 500,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"error": "Failed to retrieve item from DynamoDB", "details": str(e)})
        }
