provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  environment         = "dev"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id      = module.vpc.vpc_id
  environment = "dev"
}

module "ec2" {
  source = "./modules/ec2"

  instance_count    = 6
  subnet_ids        = module.vpc.public_subnet_ids
  security_group_id = module.security_group.security_group_id
  environment       = "dev"
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.security_group.security_group_id
}

output "instance_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = module.ec2.public_ips
}

output "ssh_private_key_path" {
  description = "Path to the SSH private key"
  value       = module.ec2.private_key_path
}

output "ssh_connection_strings" {
  description = "SSH connection strings for each instance"
  value = [
    for ip in module.ec2.public_ips :
    "ssh -i ${module.ec2.private_key_path} ubuntu@${ip}"
  ]
}