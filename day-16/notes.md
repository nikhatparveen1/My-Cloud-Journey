# Day 16 — Terraform Basics

## What is Terraform?

Terraform is Infrastructure as Code (IaC).
It allows infrastructure to be defined and managed using configuration files.

## Provider

A provider allows Terraform to communicate with a platform/API.

Example:

AWS provider → AWS API

## Resource

A resource represents infrastructure managed by Terraform.

Example:

aws_instance
aws_security_group

## Terraform State

Terraform state records the infrastructure Terraform manages.

Main state file:

terraform.tfstate

Never commit Terraform state to GitHub.

## Terraform Workflow

terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy

## Important Concepts

Desired state:
What the Terraform configuration declares.

Actual state:
What exists in AWS.

Terraform compares these and determines required changes.

## Day 16 Architecture

Terraform
    ↓
AWS Provider
    ↓
Security Group
    ↓
EC2
    ↓
Nginx
    ↓
HTTP

## Security

SSH should be restricted to my IP using /32.

HTTP can be publicly accessible when required by the application.

## Commands Practiced

terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
terraform show
terraform state list
terraform destroy
