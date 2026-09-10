# Day 17 — Terraform Full Lifecycle

## Terraform Workflow

terraform init
- Initializes Terraform project
- Downloads required providers

terraform fmt
- Formats Terraform configuration

terraform validate
- Checks Terraform configuration validity

terraform plan
- Shows proposed infrastructure changes
- Does not create resources

terraform apply
- Applies the Terraform configuration
- Creates/changes infrastructure

terraform destroy
- Removes Terraform-managed infrastructure

## Core Mental Model

main.tf
    ↓
terraform plan
    ↓
Review
    ↓
terraform apply
    ↓
AWS infrastructure
    ↓
terraform destroy
    ↓
Cleanup

## Important

plan = preview
apply = execute
destroy = cleanup

## Terraform State

terraform.tfstate records infrastructure Terraform manages.

Never commit:
- terraform.tfstate
- .terraform/
- .pem
- credentials
- secrets
