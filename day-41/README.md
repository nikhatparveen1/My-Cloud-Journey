# Day 41 — Terraform Cleanup & Infrastructure Lifecycle

## Goal

Clean up the temporary Day 39 AWS infrastructure
while preserving the Terraform code and learning notes
in GitHub.

## Day 39 Resources

Created:

- EC2 t3.micro
- Docker EC2 security group

## Day 41 Cleanup

Destroyed:

- Day 39 EC2
- Day 39 security group

The Terraform code remains in GitHub.

## Important Terraform Commands

Check resources:

terraform state list

Inspect infrastructure:

terraform show

Preview destruction:

terraform plan -destroy

Destroy managed resources:

terraform destroy

## Important Lesson

Terraform manages infrastructure lifecycle.

terraform apply
→ creates/updates infrastructure

terraform plan
→ previews changes

terraform destroy
→ removes resources managed by that Terraform state

## Cost Safety

Temporary AWS compute should be deleted when it is
no longer required for the current learning task.

Do not delete shared networking or unrelated resources
just because a project is finished.

## GitHub

Keep:

- Terraform source files
- README files
- learning notes
- .gitignore

Do not commit:

- terraform.tfvars
- terraform.tfstate
- .terraform/

## Main Concept

AWS resources can be temporary.

Infrastructure code is permanent knowledge.

The infrastructure can be recreated later from Terraform.

