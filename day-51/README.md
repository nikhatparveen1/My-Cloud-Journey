# Day 51 — Lambda Fundamentals + boto3

## Goal

Learn AWS Lambda fundamentals and Python boto3 basics.

## Lambda

AWS Lambda is a serverless compute service.

Lambda executes code in response to events.

Basic flow:

Event
 ↓
Lambda Function
 ↓
Handler
 ↓
Python Code
 ↓
Response

## Lambda Handler

Example:

def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": "Hello from AWS Lambda"
    }

## Important Lambda Concepts

Function
→ Code executed by Lambda.

Handler
→ Function Lambda invokes.

Event
→ Input provided to the function.

Context
→ Information about the Lambda execution environment.

Execution Role
→ IAM role that gives Lambda permissions to AWS services.

## boto3

boto3 is the AWS SDK for Python.

Pattern:

import boto3

client = boto3.client("service")

Examples:

s3 = boto3.client("s3")

sts = boto3.client("sts")

rekognition = boto3.client("rekognition")

dynamodb = boto3.client("dynamodb")

## AWS CLI vs boto3

AWS CLI:

aws sts get-caller-identity

Python:

import boto3

sts = boto3.client("sts")
response = sts.get_caller_identity()

Both communicate with AWS APIs.

## Important Security Rule

Never hard-code:

AWS access keys
AWS secret keys

Lambda will later use an IAM execution role.

## Future Project

S3
 ↓
Lambda
 ↓
Rekognition
 ↓
DynamoDB
 ↓
API Gateway

## Commands Practiced

aws --version

aws configure get region

aws sts get-caller-identity

aws lambda list-functions --region ap-south-2

python3

python3 -c "import boto3; print(boto3.__version__)"

## Main Lesson

Lambda lets us run application code without managing the underlying server.

boto3 lets Python communicate with AWS services.

