variable "aws_region" {
  description = "AWS region for EKS"
  type        = string
  default     = "ap-south-2"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "my-cloud-journey-eks"
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.34"
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for EKS"
  type        = list(string)
}

variable "node_instance_type" {
  description = "EKS worker node instance type"
  type        = string
  default     = "t3.small"
}
