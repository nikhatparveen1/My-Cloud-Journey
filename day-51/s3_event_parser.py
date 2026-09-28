def lambda_handler(event, context):

    record = event["Records"][0]

    bucket = record["s3"]["bucket"]["name"]
    key = record["s3"]["object"]["key"]

    print("Bucket:", bucket)
    print("Object:", key)

    return {
        "statusCode": 200,
        "body": f"Received {key} from {bucket}"
    }

