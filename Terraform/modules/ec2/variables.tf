variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 6
}

variable "subnet_ids" {
  description = "Subnet IDs for EC2 instances"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}