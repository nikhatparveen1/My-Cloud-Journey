# Day 52–53 — S3 Events + Lambda IAM

## Day 52 — S3 Event Notifications

S3 can generate events when objects change.

Example:

User
 ↓
Upload image
 ↓
S3
 ↓
ObjectCreated event
 ↓
Lambda

Important event:

ObjectCreated

The event contains information such as:

- Bucket name
- Object key
- Event name

Example:

{
  "Records": [
    {
      "eventName": "ObjectCreated:Put",
      "s3": {
        "bucket": {
          "name": "my-demo-bucket"
        },
        "object": {
          "key": "images/cat.jpg"
        }
      }
    }
  ]
}

Important concept:

Event-driven architecture means a service reacts to an event
instead of repeatedly polling for changes.

---

## Day 53 — Lambda IAM Execution Role

Lambda needs an IAM execution role.

Flow:

Lambda
 ↓
Execution Role
 ↓
Permissions
 ↓
AWS Services

IAM has two important concepts:

### Trust Policy

Answers:

"Who can assume this role?"

For Lambda:

lambda.amazonaws.com

### Permission Policy

Answers:

"What can the role do?"

Example:

s3:GetObject

Important distinction:

Trust = who can use the role

Permission = what the role can do

---

## Least Privilege

Give only the permissions the Lambda function requires.

Avoid:

AdministratorAccess

when the Lambda only needs:

s3:GetObject

---

## Future Architecture

S3
 ↓
S3 Event
 ↓
Lambda
 ↓
boto3
 ↓
Rekognition
 ↓
DynamoDB

---

## Important Security Rule

Never hard-code AWS access keys or secret keys.

Use IAM roles for AWS workloads.

---

## Main Lessons

Day 52:

S3 can trigger Lambda using event notifications.

Day 53:

Lambda uses an IAM execution role to obtain permissions.

Most important distinction:

TRUST POLICY
= Who can assume the role?

PERMISSION POLICY
= What can the role do?

