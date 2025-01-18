# 🏗️ AWS Infrastructure with Terraform Modules

This project implements a modular AWS infrastructure using Terraform, creating a complete VPC setup with EC2 instances and security configurations.

## 🏛️ Architecture Overview

The infrastructure consists of:

- VPC with public and private subnets
- Internet Gateway
- Security Groups
- Multiple EC2 instances
- SSH Key Pair for secure access

## 🔧 Infrastructure Components

### 1. VPC Module (`./modules/vpc`)
- Custom VPC with DNS support
- 2 Public Subnets (for external access)
- 2 Private Subnets (for internal resources)
- Internet Gateway for public internet access
- Route Tables for network traffic management

### 2. Security Group Module (`./modules/security_group`)
Manages inbound/outbound traffic with the following rules:
- SSH (22)
- HTTP (80)
- HTTPS (443)
- SMTP (25)
- Custom ports (3000-10000)
- Kubernetes API (6443)
- SMTPS (465)
- NodePort Services (30000-32767)
- All outbound traffic allowed

### 3. EC2 Module (`./modules/ec2`)
- Ubuntu 20.04 LTS instances
- t2.medium instance type
- Auto-generated SSH key pair
- Distributed across public subnets

## 🚀 Getting Started

### Prerequisites
- Terraform installed (v1.5.7 or later)
- AWS CLI configured with appropriate credentials
- Git (for cloning this repository)

### 🔑 Configuration

1. Clone the repository:
```bash
git clone <repository-url>
cd <repository-name>
```
2. Initialize Terraform:
```bash
terraform init
```
3. Review and modify variables in:
- terraform.tfvars (create if not exists)
- Or use command line variables

## 🏃‍♂️ Deployment
1. Review the deployment plan:
```bash
terraform plan
```
2. Apply the configuration:
```bash
terraform init
```

## 🔍 Infrastructure Details
VPC Configuration:

    CIDR Block: 10.0.0.0/16
    Public Subnets: 
    - 10.0.1.0/24 (us-east-1a)
    - 10.0.2.0/24 (us-east-1b)
    Private Subnets:
    - 10.0.3.0/24 (us-east-1a)
    - 10.0.4.0/24 (us-east-1b)

EC2 Instances:

   - Count: 6 instances
   - Type: t2.medium
   - OS: Ubuntu 20.04 LTS
   - Auto-distributed across public subnets

## 📝 Outputs
After successful deployment, you'll receive:

   - VPC ID
   - Public and Private Subnet IDs
   - Security Group ID
   - EC2 Instance Public IPs
   - SSH Private Key Path
   - Ready-to-use SSH connection strings

## 🔒 Security

   - All sensitive traffic is restricted by security groups
   - SSH access is secured with auto-generated key pairs
   - Private subnets are isolated from direct internet access
   - Security group rules follow the principle of least privilege
   
## 🛠️ Maintenance
Updating Infrastructure
```bash
# Update your terraform files then:
terraform plan    # Review changes
terraform apply   # Apply changes
```

Destroying Infrastructure
```bash
terraform destroy
```

## ⚠️ Important Notes
  1. Always review security group rules before deployment
  2. Keep the generated SSH private key secure
  3. Monitor AWS costs after deployment
  4. Regularly update AMI IDs for security patches

## 📚 Module Structure
```bash
.
├── main.tf
├── modules/
│   ├── vpc/
│   ├── security_group/
│   └── ec2/
├── outputs.tf
└── variables.tf
```