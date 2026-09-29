# Day 63 — Lambda to DynamoDB Integration

## Overview
Connected processing Lambda (`day54-57-s3-logger`) to write Rekognition label outputs into DynamoDB table `day54-57-image-results`.

## Key Changes
* Attached IAM policy `Day54-57-DynamoDB-PutItem` to Lambda execution role.
* Updated `lambda_function.py` to write parsed labels with Decimal confidence scores into DynamoDB.
