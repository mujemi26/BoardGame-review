# 🤖 Ansible Configuration for EC2 Instances

## 📋 Overview
This repository contains Ansible configurations for automating the setup of EC2 instances with Docker and Kubernetes components.

## 🏗️ Project Structure
```
UltimateDevOps_Project/
├── Ansible/
│   ├── ansible.cfg
│   ├── inventory
│   ├── install-book.yml
│   ├── k8s-requirements.yml
│   └── ping.yml
└── Scripts/
    ├── install.sh
    └── k8s.sh
```

## 🛠️ Configuration Files

### 1. Ansible Configuration (`ansible.cfg`)
```ini
[defaults]
inventory = ./inventory
host_key_checking = False
private_key_file = ../modules/ec2/dev-key.pem
remote_user = ubuntu
```

### 2. Inventory File (`inventory`)
```ini
[ec2_instances]
master ansible_host=52.54.108.249
slave-1 ansible_host=54.163.123.113
slave-2 ansible_host=3.91.32.219
```

## 📜 Playbooks

### 1. Connectivity Test (`ping.yml`)
- Tests EC2 instance connectivity
- Checks system uptime
```bash
ansible-playbook ping.yml
```

### 2. Basic Installation (`install-book.yml`)
Installs:
- Docker
- Kubernetes repositories
- Required dependencies
```bash
ansible-playbook install-book.yml
```

### 3. Kubernetes Setup (`k8s-requirements.yml`)
Installs:
- kubeadm v1.28.1
- kubelet v1.28.1
- kubectl v1.28.1
```bash
ansible-playbook k8s-requirements.yml
```

## 🚀 Getting Started

1. **Verify inventory connectivity**:
```bash
ansible all -m ping
```

2. **Run installation playbook**:
```bash
ansible-playbook install-book.yml
```

3. **Install Kubernetes components**:
```bash
ansible-playbook k8s-requirements.yml
```

## 🔑 Prerequisites
- Ansible installed on control node
- SSH access to EC2 instances
- Valid AWS private key (`.pem` file)

## 🔒 Security Features
- SSH key-based authentication
- Host key checking disabled for automation
- Privilege escalation (sudo) enabled

## ⚙️ Environment Details
- Ubuntu EC2 instances
- Remote user: ubuntu
- Private key location: `../modules/ec2/dev-key.pem`

## 📝 Script Details

### 

install.sh


- Updates package repository
- Installs Docker
- Configures Docker permissions
- Sets up Kubernetes repositories

### 

k8s.sh


- Installs specific versions of:
  - kubeadm (1.28.1)
  - kubelet (1.28.1)
  - kubectl (1.28.1)

## 🔍 Verification
```bash
# Check Docker installation
ansible ec2_instances -m shell -a "docker --version"

# Verify Kubernetes tools
ansible ec2_instances -m shell -a "kubectl version --client"
```

## ⚠️ Troubleshooting
1. SSH connection issues:
   - Verify key permissions (600)
   - Check security group rules
   - Confirm instance public IPs

2. Privilege escalation:
   - Ensure sudo rights
   - Check become: yes in playbooks



## 📫 Support
- Create an issue for bugs
- Submit PRs for improvements
- Contact repository maintainers

---
*Remember to replace private key paths and IP addresses according to your setup.*