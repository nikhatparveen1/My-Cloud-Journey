variable "public_subnet_id" {
  description = "Existing public subnet for the Day 39 EC2"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR allowed to SSH to the EC2 instance"
  type        = string
}

variable "app_cidr" {
  description = "CIDR allowed to access Flask on port 5000"
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
  default     = "day-12-key"
}

