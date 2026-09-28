from lambda_function import lambda_handler

event = {
    "message": "Day 51 test"
}

context = {}

response = lambda_handler(event, context)

print(response)

