def lambda_handler(event, context):
    print("Hello from Day 51 Lambda!")

    return {
        "statusCode": 200,
        "body": "Hello from AWS Lambda"
    }

