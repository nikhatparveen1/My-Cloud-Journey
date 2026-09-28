import json
from s3_event_parser import lambda_handler

with open("sample_s3_event.json") as f:
    event = json.load(f)

response = lambda_handler(event, {})

print(response)


